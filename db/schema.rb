# encoding: UTF-8
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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20140625173553) do

  create_table "orders", force: true do |t|
    t.string   "time_created"
    t.string   "time_modified"
    t.string   "ref_number"
    t.string   "duedate"
    t.string   "expected_drive"
    t.string   "total_amount"
    t.string   "is_manually_closed"
    t.string   "is_fully_received"
    t.string   "custom_field_authorized_buyer"
    t.string   "custom_field_status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "password_hash"
    t.string   "password_salt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
