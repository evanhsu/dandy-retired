class CrewmembersController < ApplicationController
  before_filter :require_login

  # GET /crewmembers
  # GET /crewmembers.xml
  def index
    @crewmembers = Crewmember.find(:all, :order => [:crew_id, :lastname, :firstname])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @crewmembers }
    end
  end

  # GET /crewmembers/1
  # GET /crewmembers/1.xml
  def show
    @crewmember = Crewmember.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @crewmember }
    end
  end

  # GET /crewmembers/new
  # GET /crewmembers/new.xml
  def new
    @crewmember = Crewmember.new

    respond_to do |format|
      format.html { render crew_path(@crewmember.crew)}
      format.xml  { render :xml => @crewmember }
    end
  end

  def new_crewmember_for_crew
    @crewmember = Crewmember.new
    @crewmember.crew_id = params[:id]

    respond_to do |format|
      format.html { render :new }
      format.xml  { render :xml => @crewmember }
    end
  end
  
  # GET /crewmembers/1/edit
  def edit
    @crewmember = Crewmember.find(params[:id])
  end

  # POST /crewmembers
  # POST /crewmembers.xml
  def create
    @crewmember = Crewmember.new(params[:crewmember])

    respond_to do |format|
      if @crewmember.save
        format.html { redirect_to(crewmembers_for_crew_path(@crewmember.crew), :notice => 'Crewmember was successfully created.') }
        format.xml  { render :xml => @crewmember, :status => :created, :location => @crewmember }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @crewmember.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /crewmembers/1
  # PUT /crewmembers/1.xml
  def update
    @crewmember = Crewmember.find(params[:id])

    respond_to do |format|
      if @crewmember.update_attributes(params[:crewmember])
        format.html { redirect_to(crewmembers_for_crew_url(@crewmember.crew), :notice => 'Crewmember was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @crewmember.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /crewmembers/1
  # DELETE /crewmembers/1.xml
  def destroy
    @crewmember = Crewmember.find(params[:id])
    @crewmember.destroy

    respond_to do |format|
      format.html { redirect_to(:back) }
      format.xml  { head :ok }
    end
  end
end
