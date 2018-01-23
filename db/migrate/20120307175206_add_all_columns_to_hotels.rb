class AddAllColumnsToHotels < ActiveRecord::Migration
  def self.up
    add_column :hotels, :name, :string
    add_column :hotels, :phone, :string
    add_column :hotels, :street1, :string
    add_column :hotels, :street2, :string
    add_column :hotels, :city, :string
    add_column :hotels, :state, :string
    add_column :hotels, :zip, :string
    add_column :hotels, :crew_id, :integer
  end

  def self.down
    remove_column :hotels, :name
    remove_column :hotels, :phone
    remove_column :hotels, :street1
    remove_column :hotels, :street2
    remove_column :hotels, :city
    remove_column :hotels, :state
    remove_column :hotels, :zip
    remove_column :hotels, :crew_id
  end
end
