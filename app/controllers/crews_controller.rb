class CrewsController < ApplicationController
  before_filter :require_login
  before_filter :require_admin, :only => [:new,:create]

  # GET /crews
  # GET /crews.xml
  def index
    @crews = Crew.find(:all, :order => :abbreviation)

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @crews }
    end
  end


  # GET /crews/1
  # GET /crews/1.xml
  def show
    @is_admin = current_user.is_admin?
    id = params[:id].nil? ? current_user.crew : params[:id]
    if Crew.exists?(id)
      @crew = Crew.find(id)
    else
      redirect_to crew_path(current_user.crew) and return
    end
    @crews = Crew.find(:all, :order => :abbreviation)
    @radio_groups_for_crew = @crew.radio_groups
    @static_pages = Dir.entries("public/static-pages") - [".",".."] #Remove directory links
    @static_pages.sort! {|a,b| a.downcase <=> b.downcase }

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @crewmembers }
    end
  end

  # PUT /crews/1
  # PUT /crews/1.xml
  def update
    @crew = Crew.find(params[:id])

    respond_to do |format|
      if @crew.update_attributes(params[:crew])
        format.html { redirect_to(@crew, :notice => 'Crew was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @crew.errors, :status => :unprocessable_entity }
      end
    end
  end

  # GET /crews/new
  # GET /crews/new.xml
  def new
    @crew = Crew.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @crew }
    end
  end

  # POST /crews
  # POST /crews.xml
  def create
    @crew = Crew.new(params[:crew])

    respond_to do |format|
      if @crew.save
        format.html { redirect_to(crews_url, :notice => 'Crew was successfully created.') }
        format.xml  { render :xml => @crew, :status => :created, :location => @crew }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @crew.errors, :status => :unprocessable_entity }
      end
    end
  end

  # GET /crews/1/edit
  def edit
    @crew = Crew.find(params[:id])
    redirect_to crew_path(params[:id]) unless (current_user.is_admin? or (current_user.crew_id == @crew.id))
  end

  def crewmembers
    prawnto :prawn => {
      :page_size => PdfSpecs::PAGE_SIZE, # (Handy Dandy page size)
      :margin => PdfSpecs::PAGE_MARGIN # Top, Right, Bottom, Left
    }
    @crew = Crew.find(params[:id])
    @crewmembers = Crewmember.find_all_by_crew_id(params[:id], :order => [:lastname, :firstname])

    respond_to do |format|
      format.html # crewmembers.html.erb
      format.xml  { render :xml => @crewmembers }
      format.pdf # crewmembers.pdf.prawn
    end
  end

  def info
    prawnto :prawn => {
      :page_size => PdfSpecs::PAGE_SIZE, # (Handy Dandy page size)
      :margin => PdfSpecs::PAGE_MARGIN # Top, Right, Bottom, Left
    }
    @helibase = Helibase.find_by_crew_id(params[:id])
    @crew = Crew.find(params[:id])
    @hotels = Hotel.find_all_by_crew_id(params[:id], :order => [:state,:city,:name])

    respond_to do |format|
      format.html # info.html.erb
      format.pdf # info.pdf.prawn
    end
  end

  def hotels
    @crew = Crew.find(params[:id])
    @hotels = Hotel.find_all_by_crew_id(params[:id])
  end

  def helibase
    if !current_user.is_admin? && (current_user.crew_id != params[:id].to_i)
      redirect_to info_for_crew_url(params[:id], :format => :pdf) and return
    end

    @crew = Crew.find(params[:id])
    @helibase = Helibase.find_by_crew_id(params[:id])

    #Prevent a crew from changing the affiliation of their helibase to a different crew
    @lock_helibase_affiliation = current_user.is_admin? ? false : true
    
  end

  # GET /crews/1/staffing
  def staffing
    if params[:id] == "own_crew"
      redirect_to staffing_for_crew_url(current_user.crew_id.to_i) and return
    else
      id = params[:id].to_i
    end

    if !current_user.is_admin? && (current_user.crew_id != id)
      redirect_to root_url and return
    end

    redirect_to root_url and return unless Crew.exists?(id)

    # Retrieve the most recent staffing info to pre-populate the form
    # However, this 'edit' action creates a new entry (instead of editing an existing database entry).
    # It is more intuitive to use the 'edit' action for this instead of the 'new' action
    #   because of the nature of the data (users prefer to 'edit' their status instead of 'creating' a new status)
    @old_staffing_level = StaffingLevel.find_by_crew_id(id, :order => "created_at DESC", :limit => 1 )
    @staffing_level = @old_staffing_level.nil? ? StaffingLevel.new : @old_staffing_level.dup
    @current_user = current_user
    @crew = Crew.find(id) # Already verified that Crew.exists?
    @training_priorities = TrainingPriority.find_all_by_crew_id(@crew.id, :order => "priority ASC")
  end
end
