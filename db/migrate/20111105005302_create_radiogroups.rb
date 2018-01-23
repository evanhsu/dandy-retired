class CreateRadiogroups < ActiveRecord::Migration
  def self.up
    create_table :radiogroups do |t|
      t.string :name
      t.integer :dispatchcenter_id
      t.integer :groupnumber
      t.integer :crew_id

      t.timestamps
    end
  end

  def self.down
    drop_table :radiogroups
  end
end
