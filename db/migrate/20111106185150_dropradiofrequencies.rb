class Dropradiofrequencies < ActiveRecord::Migration
  def self.up
    drop_table :radiofrequencies
  end

  def self.down
  end
end
