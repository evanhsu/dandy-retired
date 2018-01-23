class Crew < ActiveRecord::Base
  has_many :crewmembers
  has_many :radio_groups
  has_many :frequencies, :through => :radio_groups
  has_many :hotels
  has_many :users
  has_many :staffing_levels
  has_many :training_priorities
  has_one :helibase
  accepts_nested_attributes_for :crewmembers
  accepts_nested_attributes_for :training_priorities

  def editable_by_user(user)
    return true if user.account_type == "admin"
    return true if user.crew_id == self.id
    return false
  end

end
