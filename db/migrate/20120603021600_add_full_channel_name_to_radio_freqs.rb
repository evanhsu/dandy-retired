class AddFullChannelNameToRadioFreqs < ActiveRecord::Migration
  def self.up
    add_column :frequencies, :full_name, :string
  end

  def self.down
    remove_column :frequencies, :full_name
  end
end
