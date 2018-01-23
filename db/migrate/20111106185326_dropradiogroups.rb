class Dropradiogroups < ActiveRecord::Migration
  def self.up
    drop_table :radiogroups
  end

  def self.down
  end
end
