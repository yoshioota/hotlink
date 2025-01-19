# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 0) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "bookmark_colors", force: :cascade do |t|
    t.integer "position", default: 1
    t.string "name", null: false
    t.string "css"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_bookmark_colors_on_name", unique: true
  end

  create_table "bookmarks", force: :cascade do |t|
    t.text "url", null: false
    t.text "title", null: false
    t.boolean "archived", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "favicon_url"
    t.index ["archived"], name: "index_bookmarks_on_archived"
    t.index ["title"], name: "index_bookmarks_on_title"
    t.index ["url"], name: "index_bookmarks_on_url", unique: true
  end

  create_table "bookmarks_bookmark_colors", force: :cascade do |t|
    t.bigint "bookmark_id", null: false
    t.bigint "bookmark_color_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bookmark_color_id"], name: "index_bookmarks_bookmark_colors_on_bookmark_color_id"
    t.index ["bookmark_id", "bookmark_color_id"], name: "idx_on_bookmark_id_bookmark_color_id_aa54d9ca57", unique: true
    t.index ["bookmark_id"], name: "index_bookmarks_bookmark_colors_on_bookmark_id"
  end

  add_foreign_key "bookmarks_bookmark_colors", "bookmark_colors", on_delete: :cascade
  add_foreign_key "bookmarks_bookmark_colors", "bookmarks", on_delete: :cascade
end
