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

ActiveRecord::Schema.define(version: 20141015190911) do

  create_table "buyers", force: true do |t|
    t.string   "phone"
    t.string   "cell"
    t.string   "office"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  create_table "commenths", force: true do |t|
    t.string   "ref_number"
    t.string   "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", force: true do |t|
    t.string   "ref_number"
    t.string   "total_amount"
    t.string   "is_manually_closed"
    t.string   "is_fully_received"
    t.string   "custom_field_authorized_buyer"
    t.string   "custom_field_status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "decline"
    t.string   "decline_date"
    t.string   "decline_by"
    t.string   "approve_date"
    t.string   "approve_by"
    t.string   "receive_date"
    t.string   "receive_by"
    t.string   "expected_date"
    t.string   "vendor_name"
    t.string   "date_due"
    t.string   "customer_name"
    t.string   "project_name"
    t.string   "sub_approval"
    t.string   "terms"
    t.string   "address"
    t.string   "city"
    t.string   "user_comments"
    t.string   "decliner_comments"
    t.string   "memo"
    t.string   "item"
    t.string   "mpn"
    t.string   "wc"
    t.string   "classz"
    t.string   "track"
    t.string   "po_status"
    t.text     "dcomments"
    t.text     "memot"
    t.text     "ucommentst"
    t.text     "acomments"
    t.string   "unit_cost"
  end

  create_table "ordlns", force: true do |t|
    t.string   "ref_number"
    t.string   "is_fully_received"
    t.string   "custom_field_authorized_buyer"
    t.string   "custom_field_status"
    t.string   "decline"
    t.string   "decline_rpt"
    t.string   "decline_date"
    t.string   "decline_by"
    t.string   "approve_date"
    t.string   "approve_by"
    t.string   "receive_date"
    t.string   "receive_by"
    t.string   "vendor_ref_list_id"
    t.string   "ord_line_qty"
    t.string   "ord_line_desc"
    t.string   "ord_line_rate"
    t.string   "ord_line_amount"
    t.string   "customer_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "device"
    t.string   "assemblies"
    t.string   "lead_time"
    t.string   "product"
    t.string   "project_id"
    t.string   "kanban"
    t.string   "date_due"
    t.string   "expected_date"
    t.string   "terms"
    t.string   "address"
    t.string   "city"
    t.string   "user_comments"
    t.string   "decliner_comments"
    t.string   "memo"
    t.string   "item"
    t.string   "mpn"
    t.string   "wc"
    t.string   "classz"
    t.string   "unitm"
    t.text     "desctext"
    t.text     "memot"
    t.text     "ucommentst"
    t.string   "unit_cost"
  end

  create_table "users", force: true do |t|
    t.string   "email"
    t.string   "password_hash"
    t.string   "password_salt"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "amount"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "title"
    t.string   "buyer"
    t.string   "first_check"
  end

  create_table "watchers", force: true do |t|
    t.string   "po"
    t.string   "project"
    t.string   "customer"
    t.string   "approver"
    t.string   "task"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
