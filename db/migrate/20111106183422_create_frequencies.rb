class CreateFrequencies < ActiveRecord::Migration
  def self.up
    create_table :frequencies do |t|
      t.integer :radio_group_id
      t.integer :channel
      t.string :name
      t.string :rx
      t.string :rx_tone
      t.string :tx
      t.string :tx_tone
      t.string :band
      t.string :repeater_location
      t.string :coverage_area

      t.timestamps
    end
  end

  def self.down
    drop_table :frequencies
  end
end
