class Crewmember < ActiveRecord::Base
  belongs_to :crew
  has_many :rotation_board_slots

end
