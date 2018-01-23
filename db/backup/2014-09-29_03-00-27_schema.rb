# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20140310223606) do

  create_table "crewmembers", :force => true do |t|
    t.integer  "crew_id"
    t.string   "firstname"
    t.string   "lastname"
    t.string   "cellphone"
    t.string   "daysoff"
    t.integer  "rappelweight"
    t.integer  "helitackweight"
    t.integer  "spotterweight"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "crews", :force => true do |t|
    t.string   "name"
    t.string   "abbreviation"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "info_complete", :default => false
    t.string   "charge_code"
    t.string   "override"
  end

  create_table "dispatch_centers", :force => true do |t|
    t.string   "name"
    t.string   "abbreviation"
    t.string   "callsign"
    t.string   "phone1"
    t.string   "phone2"
    t.string   "phone24"
    t.string   "fax"
    t.string   "location"
    t.string   "fscoverage"
    t.string   "blmcoverage"
    t.string   "parkcoverage"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "frequencies", :force => true do |t|
    t.integer  "radio_group_id"
    t.integer  "channel"
    t.string   "name"
    t.string   "rx"
    t.string   "rx_tone"
    t.string   "tx"
    t.string   "tx_tone"
    t.string   "band"
    t.string   "repeater_location"
    t.string   "coverage_area"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "full_name"
  end

  create_table "helibases", :force => true do |t|
    t.integer  "crew_id"
    t.string   "street"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "main_phone"
    t.string   "fax"
    t.string   "airport_identifier"
    t.string   "elevation"
    t.integer  "lat_degrees"
    t.float    "lat_minutes"
    t.integer  "lon_degrees"
    t.float    "lon_minutes"
    t.string   "nearest_airport_name"
    t.string   "nearest_airport_identifier"
    t.string   "nearest_airport_elevation"
    t.string   "department1_title"
    t.string   "department1_contact_name"
    t.string   "department1_phone"
    t.string   "department2_title"
    t.string   "department2_contact_name"
    t.string   "department2_phone"
    t.string   "department3_title"
    t.string   "department3_contact_name"
    t.string   "department3_phone"
    t.string   "base_manager_name"
    t.string   "base_manager_phone"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "airport_name"
  end

  create_table "hotels", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "phone"
    t.string   "street1"
    t.string   "street2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.integer  "crew_id"
  end

  create_table "radio_groups", :force => true do |t|
    t.string   "name"
    t.integer  "dispatch_center_id"
    t.string   "group_number"
    t.integer  "crew_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "rotation_board_slots", :force => true do |t|
    t.integer  "board_state"
    t.integer  "person_id"
    t.integer  "position"
    t.integer  "assigned_number"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "staffing_levels", :force => true do |t|
    t.integer  "crew_id"
    t.string   "training_needs"
    t.string   "resource_1_name"
    t.string   "resource_1_detail"
    t.string   "resource_1_location"
    t.string   "resource_1_hrap_surplus"
    t.string   "resource_1_status"
    t.string   "resource_1_comment"
    t.string   "resource_1_contract_end_date"
    t.string   "resource_2_name"
    t.string   "resource_2_detail"
    t.string   "resource_2_location"
    t.string   "resource_2_hrap_surplus"
    t.string   "resource_2_status"
    t.string   "resource_2_comment"
    t.string   "resource_2_contract_end_date"
    t.string   "resource_3_name"
    t.string   "resource_3_detail"
    t.string   "resource_3_location"
    t.string   "resource_3_hrap_surplus"
    t.string   "resource_3_status"
    t.string   "resource_3_comment"
    t.string   "resource_3_contract_end_date"
    t.string   "resource_4_name"
    t.string   "resource_4_detail"
    t.string   "resource_4_location"
    t.string   "resource_4_hrap_surplus"
    t.string   "resource_4_status"
    t.string   "resource_4_comment"
    t.string   "resource_4_contract_end_date"
    t.string   "resource_5_name"
    t.string   "resource_5_detail"
    t.string   "resource_5_location"
    t.string   "resource_5_hrap_surplus"
    t.string   "resource_5_status"
    t.string   "resource_5_comment"
    t.string   "resource_5_contract_end_date"
    t.string   "resource_6_name"
    t.string   "resource_6_detail"
    t.string   "resource_6_location"
    t.string   "resource_6_hrap_surplus"
    t.string   "resource_6_status"
    t.string   "resource_6_comment"
    t.string   "resource_6_contract_end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "training_priorities", :force => true do |t|
    t.integer  "priority"
    t.string   "name"
    t.integer  "crew_id"
    t.string   "qualification"
    t.boolean  "available"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "encrypted_password"
    t.string   "salt"
    t.string   "account_type"
    t.integer  "crew_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
