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

ActiveRecord::Schema.define(version: 20191229062138) do

  create_table "categories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "paints", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "user_id"
    t.bigint "senga_id"
    t.string "image"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["senga_id"], name: "index_paints_on_senga_id"
    t.index ["user_id"], name: "index_paints_on_user_id"
  end

  create_table "senga_categories", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "senga_id"
    t.bigint "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_senga_categories_on_category_id"
    t.index ["senga_id"], name: "index_senga_categories_on_senga_id"
  end

  create_table "senga_likes", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "user_id"
    t.bigint "senga_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["senga_id"], name: "index_senga_likes_on_senga_id"
    t.index ["user_id"], name: "index_senga_likes_on_user_id"
  end

  create_table "senga_requests", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "user_id"
    t.bigint "senga_id"
    t.boolean "permission"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["senga_id"], name: "index_senga_requests_on_senga_id"
    t.index ["user_id"], name: "index_senga_requests_on_user_id"
  end

  create_table "sengas", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "user_id"
    t.string "image"
    t.string "tittle"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_sengas_on_user_id"
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "email"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "image"
  end

  add_foreign_key "paints", "sengas"
  add_foreign_key "paints", "users"
  add_foreign_key "senga_categories", "categories"
  add_foreign_key "senga_categories", "sengas"
  add_foreign_key "senga_likes", "sengas"
  add_foreign_key "senga_likes", "users"
  add_foreign_key "senga_requests", "sengas"
  add_foreign_key "senga_requests", "users"
  add_foreign_key "sengas", "users"
end
