class CreateCrewmembers < ActiveRecord::Migration
  def self.up
    create_table :crewmembers do |t|
      t.integer :crew_id
      t.string :firstname
      t.string :lastname
      t.string :cellphone
      t.string :daysoff
      t.integer :rappelweight
      t.integer :helitackweight
      t.integer :spotterweight

      t.timestamps
    end
  end

  def self.down
    drop_table :crewmembers
  end
end
