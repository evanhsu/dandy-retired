class ChangeRadioGroupsGroupNumberToString < ActiveRecord::Migration
  def self.up
    change_column :radio_groups, :group_number, :string
  end

  def self.down
    change_column :radio_groups, :group_number, :integer
  end
end
