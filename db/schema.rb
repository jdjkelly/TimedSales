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

ActiveRecord::Schema.define(:version => 20120115212945) do

  create_table "sales", :force => true do |t|
    t.string   "product"
    t.string   "variant"
    t.datetime "start"
    t.datetime "end"
    t.decimal  "price"
    t.integer  "shop_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "compare_at"
  end

  add_index "sales", ["shop_id"], :name => "index_sales_on_shop_id"

  create_table "shops", :force => true do |t|
    t.string   "api_url"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
