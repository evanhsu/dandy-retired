class RotationBoardController < ApplicationController

  # GET /rotation_board
  # GET /rotation_board.xml
  def index
    @board_state = params[:state].nil? ? RotationBoardSlot.maximum(:board_state) : params[:state]
    #@current_board_slots = RotationBoardSlot.find(:all, :having => "board_state = #{@board_state}", :order => :position)
    #@current_board_slots = ["Tim Lyda", "Evan Hsu", "Sarah Uvodich", "Roylynn Taylor", "Nick Sailer", "Andrew Larrimore", "Justin Holloway", "Nando Garcia", "Jenna Cunningham", "Blaine Vandehey", "Will McKinney", "Kevin Mayfield", "Dan Quinones"]
    @current_board_slots = Crewmember.find_all_by_crew_id(1).collect { |p| p.firstname + " " + p.lastname }
    #@last_update = @current_board_slots.first.created_at


    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @current_board_slots }
    end
  end
end