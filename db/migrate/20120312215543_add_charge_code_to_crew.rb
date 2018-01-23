class AddChargeCodeToCrew < ActiveRecord::Migration
  def self.up
    add_column :crews, :charge_code, :string
    add_column :crews, :override, :string
  end

  def self.down
    remove_column :crews, :override
    remove_column :crews, :charge_code
  end
end
