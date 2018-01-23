class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :name
      t.string :encrypted_password
      t.string :salt
      t.string :account_type
      t.integer :crew_id

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
