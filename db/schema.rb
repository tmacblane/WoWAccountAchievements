# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20101130195228) do

  create_table "accounts", :force => true do |t|
  end

  create_table "achievements", :force => true do |t|
    t.string  "achievement_id"
    t.integer "category_id"
    t.integer "points"
    t.string  "name"
    t.string  "description"
    t.integer "is_active"
  end

  create_table "categories", :force => true do |t|
    t.integer "category_type_id"
    t.integer "category_id"
    t.string  "category_name"
  end

  create_table "category_types", :force => true do |t|
    t.integer "category_type_id"
    t.string  "description"
  end

  create_table "character_achievements", :force => true do |t|
    t.integer "character_id"
    t.integer "achievement_id"
    t.integer "is_complete"
  end

  create_table "characters", :force => true do |t|
    t.string "account_id"
    t.string "character_name"
    t.string "realm_id"
  end

  create_table "realms", :force => true do |t|
    t.string "realm_local"
    t.string "realm_name"
  end

end
