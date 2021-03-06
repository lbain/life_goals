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

ActiveRecord::Schema.define(version: 20140203101233) do

  create_table "categories", force: true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories_goals", id: false, force: true do |t|
    t.integer "category_id"
    t.integer "goal_id"
  end

  create_table "goals", force: true do |t|
    t.string   "title"
    t.datetime "due_date"
    t.string   "schedule_yaml"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "next_due"
    t.string   "precision"
    t.boolean  "done",          default: false
  end

  create_table "tasks", force: true do |t|
    t.integer  "goal_id"
    t.boolean  "done",       default: false
    t.datetime "due_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
