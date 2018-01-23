class Helibase < ActiveRecord::Base
  belongs_to :crew
  accepts_nested_attributes_for :crew
  
end
