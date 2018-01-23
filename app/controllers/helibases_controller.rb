class HelibasesController < ApplicationController
  before_filter :require_admin, :only => [:new, :create]

  # GET /helibases
  # GET /helibases.xml
  def index
    @helibases = Helibase.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @helibases }
    end
  end

  # GET /helibases/1
  # GET /helibases/1.xml
  def show
    @helibase = Helibase.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @helibase }
    end
  end

  # GET /helibases/new
  # GET /helibases/new.xml
  def new
    @helibase = Helibase.new
    crews_with_helibases = Helibase.find(:all, :select => :crew_id)
    @crews_without_helibases = Crew.find(:all, :having => "id NOT IN (#{crews_with_helibases.collect{|c| c.crew_id}.join(',')})")

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @helibase }
    end
  end

  # GET /helibases/1/edit
  def edit
    @helibase = Helibase.find(params[:id])
  end

  # POST /helibases
  # POST /helibases.xml
  def create
    @helibase = Helibase.new(params[:helibase])

    respond_to do |format|
      if @helibase.save
        format.html { redirect_to(helibases_path, :notice => 'Helibase was successfully created.') }
        format.xml  { render :xml => @helibase, :status => :created, :location => @helibase }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @helibase.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /helibases/1
  # PUT /helibases/1.xml
  def update
    Crew.update(params[:crew].keys, params[:crew].values)
    @helibase = Helibase.find(params[:id])
    @crew = Crew.find(params[:helibase][:crew_id])
    respond_to do |format|
      if @helibase.update_attributes(params[:helibase])
        format.html { redirect_to(helibase_for_crew_url(@crew), :notice => 'Helibase was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @helibase.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /helibases/1
  # DELETE /helibases/1.xml
  def destroy
    @helibase = Helibase.find(params[:id])
    @helibase.destroy

    respond_to do |format|
      format.html { redirect_to(helibases_url) }
      format.xml  { head :ok }
    end
  end
end
