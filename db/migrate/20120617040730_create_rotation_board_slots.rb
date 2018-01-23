class CreateRotationBoardSlots < ActiveRecord::Migration
  def self.up
    create_table :rotation_board_slots do |t|
      t.integer :board_state
      t.integer :person_id
      t.integer :position
      t.integer :assigned_number
      t.timestamps
    end
  end

  def self.down
    drop_table :rotation_board_slots
  end
end
