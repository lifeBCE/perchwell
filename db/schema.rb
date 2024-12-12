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

ActiveRecord::Schema[7.2].define(version: 2024_12_12_042314) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "buildings", force: :cascade do |t|
    t.string "street_1", null: false
    t.string "street_2"
    t.string "city", null: false
    t.string "state", null: false
    t.string "zipcode", null: false
    t.jsonb "custom_fields", default: {}, null: false
    t.bigint "client_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_buildings_on_client_id"
  end

  create_table "clients", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "custom_field_options", force: :cascade do |t|
    t.string "value", null: false
    t.bigint "custom_field_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["custom_field_id"], name: "index_custom_field_options_on_custom_field_id"
  end

  create_table "custom_fields", force: :cascade do |t|
    t.string "name", null: false
    t.string "display_name", null: false
    t.integer "field_type", default: 0, null: false
    t.bigint "client_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_custom_fields_on_client_id"
  end

  add_foreign_key "buildings", "clients"
  add_foreign_key "custom_field_options", "custom_fields"
  add_foreign_key "custom_fields", "clients"
end
