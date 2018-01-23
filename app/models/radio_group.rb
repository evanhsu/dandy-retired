class RadioGroup < ActiveRecord::Base
  has_many    :frequencies
  belongs_to  :dispatch_center
  belongs_to  :crew
  accepts_nested_attributes_for :frequencies
end
