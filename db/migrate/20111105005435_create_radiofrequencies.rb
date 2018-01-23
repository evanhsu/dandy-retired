class CreateRadiofrequencies < ActiveRecord::Migration
  def self.up
    create_table :radiofrequencies do |t|
      t.integer :radiogroup_id
      t.integer :channel
      t.string :name
      t.string :rx
      t.string :rxtone
      t.string :tx
      t.string :txtone
      t.string :band
      t.string :repeaterlocation
      t.string :coveragearea

      t.timestamps
    end
  end

  def self.down
    drop_table :radiofrequencies
  end
end
