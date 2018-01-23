class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user
  helper_method :is_editable_by_current_user?
  helper :all
  private

  def enforce(*requirements)
    #Used as a before_filter, denies access to a controller action if any of the
    #given requirements evaluate to false.  Optionally, requirements may take
    #the array form [condition, custom_error_message].
    #Also accepts a hash of options.
    return true if current_user.account_type == "admin"
    #parse options hash
    options ||= {}
    array_of_hashes = requirements.select { |r| r.class == Hash }
    array_of_hashes.each do |hash|
      hash.each do |key,value|
        options[key] = value
      end
      requirements.delete(hash)
    end
    options[:redirect] ||= root_path

    requirements.each do |r|
      if r.class == Array
        condition = r[0]
        message = r[1]
      else
        condition = r
        message = "You don't have permission to access that page."
      end
      unless condition == true
        permission_denied(options[:redirect], message)
      end
    end
    return true
  end

  def permission_denied(redirect_path, message)
    flash[:error] = message
    redirect_path and redirect_to redirect_path
    return true
  end

  def require_login
    session[:intended_destination] = request.fullpath
    return true if current_user
    flash[:error] = flash[:auth_alert] = "Please log in."
    redirect_to :login and return
  end

  def require_admin
    session[:intended_destination] = request.fullpath
    return true if current_user && current_user.account_type == "admin"
    #flash[:error] = flash[:auth_alert] = "Admin access only"
    redirect_to crew_path(Crew.find(current_user.crew_id)) and return unless current_user == nil
    redirect_to :login and return
  end

  def permission_denied(redirect_path, message)
    flash[:error] = message
    redirect_path and redirect_to redirect_path
    return true
  end

  def is_editable_by_current_user?(a)
    # "a" can be any model with a "crew_id" parameter
    return true if current_user.account_type == "admin"
    return true if a.crew_id == current_user.crew_id
    return false
  end

  def change_session_id
    #reset the session id while preserving session data
    backup = {}
    session.each { |k,v| backup[k]=v }
    reset_session
    backup.each { |k,v| session[k]=v }
  end

  def current_user
    @current_user ||= session[:current_user_id] && User.find(session[:current_user_id])
  end
end
