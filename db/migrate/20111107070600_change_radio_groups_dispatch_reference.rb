class ChangeRadioGroupsDispatchReference < ActiveRecord::Migration
  def self.up
    rename_column :radio_groups, :dispatchcenter_id, :dispatch_center_id
  end

  def self.down
    rename_column :radio_groups, :dispatch_center_id, :dispatchcenter_id
  end
end
