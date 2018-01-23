class Frequency < ActiveRecord::Base
  belongs_to :radio_group

  validates :repeater_location, :length => {:maximum => 45, :message => "Repeater location must be 45 characters or fewer"}
end
