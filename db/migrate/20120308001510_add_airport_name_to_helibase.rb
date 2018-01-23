class AddAirportNameToHelibase < ActiveRecord::Migration
  def self.up
    add_column :helibases, :airport_name, :string
  end

  def self.down
    remove_column :helibases, :airport_name
  end
end
