class CreateRadioGroups < ActiveRecord::Migration
  def self.up
    create_table :radio_groups do |t|
      t.string :name
      t.integer :dispatchcenter_id
      t.integer :group_number
      t.integer :crew_id

      t.timestamps
    end
  end

  def self.down
    drop_table :radio_groups
  end
end
