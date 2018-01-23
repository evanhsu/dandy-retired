class StaffingLevelsController < ApplicationController
  before_filter :require_login, :except => [:index]

  def index
    if params[:history].blank?
      @staffing_levels = StaffingLevel.latest_from_each_crew
    else
      d = Date.today - (params[:history].to_i.days)
      @staffing_levels = StaffingLevel.maximum(:created_at, :group => :crew_id, :conditions => ["created_at <= ?", d], :order => :crew_id)
    end
    
    @history = params[:history]
    @age_limit_hours = 18

    @time_zone = "America/Los_Angeles"

    respond_to do |format|
      format.html
      format.xml { render :xml => @staffing_levels }
    end
  end

  # POST /staffing_levels
  # POST /staffing_levels.xml
  def create
    @staffing_level = StaffingLevel.new(params[:staffing_level])
    TrainingPriority.update(params[:training_priority].keys, params[:training_priority].values)

    respond_to do |format|
      if @staffing_level.save
        format.html { redirect_to(staffing_levels_path, :notice => "Staffing info updated!") }
        format.xml  { redirect_to(staffing_levels_path, :format => :xml) }
      else
        format.html { redirect_to(staffing_levels_path, :notice => 'Error: staffing levels could not be updated.') }
        format.xml  { render :xml => @staffing_level.errors, :status => :unprocessable_entity }
      end
    end
  end
end