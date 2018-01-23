class RadioGroupsController < ApplicationController
  before_filter :require_login, :except => [:menu]
  before_filter :require_admin, :except => [:menu, :frequencies, :update_frequencies]

  # GET /radio_groups
  # GET /radio_groups.xml
  def index
    @radio_groups = RadioGroup.all.sort_by { |a| a.group_number.to_i } #group_number is a string
=begin
    #Mass Radio Group Insert
    region = "R5"
    crew = 10
    (1..25).each do |num|
      group = region+" "+num.to_s.rjust(2, '0')
      r = RadioGroup.new({:name => "New Group", :dispatch_center_id => 1, :group_number => group, :crew_id => crew})
      r.save
      group_id = r.id

      (1..16).each do |chan|
        f = Frequency.new({:radio_group_id => group_id, :channel => chan, :name => "CH"+chan.to_s, :band => "N", :full_name => "Channel "+chan.to_s})
        f.save
      end
    end
=end
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @radio_groups }
    end
  end

  # GET /radio_groups/1
  # GET /radio_groups/1.xml
  def show
    @radio_group = RadioGroup.find(params[:id])
    @crew = Crew.find(@radio_group.crew_id)
    @dispatch_center = DispatchCenter.find(@radio_group.dispatch_center_id)

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @radio_group }
    end
  end

  # GET /radio_groups/new
  # GET /radio_groups/new.xml
  def new
    @radio_group = RadioGroup.new
    @dispatch_centers = DispatchCenter.all
    @crews = Crew.all

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @radio_group }
    end
  end

  # GET /radio_groups/1/edit
  def edit
    @radio_group = RadioGroup.find(params[:id])
    @crews = Crew.find(:all, :order => :name)
    @dispatch_centers = DispatchCenter.find(:all, :order => :name)
  end

  # POST /radio_groups
  # POST /radio_groups.xml
  def create
    @radio_group = RadioGroup.new(params[:radio_group])

    respond_to do |format|
      if @radio_group.save
        format.html { redirect_to(@radio_group, :notice => 'Radio group was successfully created.') }
        format.xml  { render :xml => @radio_group, :status => :created, :location => @radio_group }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @radio_group.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /radio_groups/1
  # PUT /radio_groups/1.xml
  def update
    @radio_group = RadioGroup.find(params[:id])

    respond_to do |format|
      if @radio_group.update_attributes(params[:radio_group])
        format.html { redirect_to(@radio_group, :notice => 'Radio group was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @radio_group.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update_frequencies
    Frequency.update(params[:frequency].keys, params[:frequency].values)
    @radio_group = RadioGroup.find(params[:id])
    if @radio_group.update_attributes(params[:radio_group])
      flash[:notice] = 'Radio Group was successfully updated.'
    else
      flash[:notice] = 'There was a problem updating the Radio Group'
    end
    redirect_to :action => "frequencies"
  end

  # DELETE /radio_groups/1
  # DELETE /radio_groups/1.xml
  def destroy
    @radio_group = RadioGroup.find(params[:id])
    @radio_group.destroy

    respond_to do |format|
      format.html { redirect_to(radio_groups_url) }
      format.xml  { head :ok }
    end
  end

  def frequencies
    prawnto :prawn => {
      :page_size => PdfSpecs::PAGE_SIZE, # (Handy Dandy page size)
      :margin => PdfSpecs::PAGE_MARGIN # Top, Right, Bottom, Left
    }
    @radio_group = RadioGroup.find(params[:id])
    @frequencies = Frequency.find_all_by_radio_group_id(@radio_group.id, :order => "channel ASC")
    @dispatch_centers = DispatchCenter.find(:all,:order => :name)

  end

  def test
    @radio_group = RadioGroup.find(params[:id])
    @frequencies = Frequency.find_all_by_radio_group_id(@radio_group.id, :order => "channel ASC")
    @dispatch_centers = DispatchCenter.find(:all,:order => :name)

    respond_to do |format|
      format.html # test.html.erb
    end
    
  end

  def menu
    @radio_groups = RadioGroup.all

    respond_to do |format|
      format.html # menu.html.erb
    end
  end
end
