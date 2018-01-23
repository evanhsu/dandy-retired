class RenameDispatchcenter < ActiveRecord::Migration
  def self.up
    rename_table :dispatchcenters, :dispatch_centers
  end

  def self.down
    rename_table :dispatch_centers, :dispatchcenters
  end
end
