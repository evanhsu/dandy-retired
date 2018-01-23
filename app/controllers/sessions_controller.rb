class SessionsController < ApplicationController
  def new
    if session[:current_user_id]
      redirect_to session[:intended_destination] and return unless session[:intended_destination].nil?
      redirect_to root_url
    else
      redirect_to root_url
    end
  end
  
  def create
    if authentic_user = User.authenticate(params[:user][:username], params[:user][:password])
      #Change session IDs to prevent session fixation attacks
      #change_session_id is defined in ApplicationController
      intent = session[:intended_destination] # Save this info before changing sessions
      change_session_id
      session[:intended_destination] = intent
      session[:current_user_id] = authentic_user.id
      redirect_to session[:intended_destination] and return unless session[:intended_destination].nil?
      redirect_to crew_url(current_user.crew_id) and return unless session[:current_user_id].blank? or current_user.crew_id.blank?
      redirect_to crews_url and return if current_user.account_type == "admin"
    end
    flash[:auth_alert] = "Your username or password was incorrect"
    redirect_to :login
  end

  def destroy
    reset_session
    flash[:notice] = "You have logged out"
    redirect_to root_url
  end
end
