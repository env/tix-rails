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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120703143018) do

  create_table "areas", :force => true do |t|
    t.string  "label"
    t.string  "polypath"
    t.decimal "x"
    t.decimal "y"
    t.integer "stack_order", :default => 0
    t.integer "chart_id"
    t.string  "type"
  end

  create_table "charts", :force => true do |t|
    t.string   "name"
    t.string   "background_image_url"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  create_table "events", :force => true do |t|
    t.string   "title"
    t.string   "headline"
    t.text     "supporting_act"
    t.text     "body"
    t.string   "image_uri"
    t.string   "image_thumb_uri"
    t.datetime "starts_at"
    t.datetime "ends_at"
    t.integer  "chart_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "tickets", :force => true do |t|
    t.decimal  "price"
    t.string   "state",      :default => "open", :null => false
    t.integer  "event_id"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
  end

  add_index "tickets", ["state"], :name => "index_tickets_on_state"

end
