class AddCompletionBookToCrews < ActiveRecord::Migration
  def self.up
    add_column :crews, :info_complete, :boolean, :default => 0
  end

  def self.down
    remove_column :crews, :info_complete
  end
end
