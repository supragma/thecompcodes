# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_09_23_172505) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "getquotes", force: :cascade do |t|
    t.string "json_blob"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "address"
    t.string "zip"
    t.boolean "authorized"
    t.boolean "contractor"
    t.boolean "prefab"
    t.boolean "dev_company"
    t.string "location"
    t.boolean "new_construction"
    t.boolean "adding"
    t.boolean "remodel"
    t.boolean "complete_remodel"
    t.boolean "tenant_improvement"
    t.boolean "structural_repair"
    t.boolean "structural_eng"
    t.string "project_other"
    t.string "size"
    t.boolean "interior_alt"
    t.boolean "exterior_alt"
    t.boolean "earth_work"
    t.boolean "site_improvements"
    t.boolean "mech_elect_plumb"
    t.boolean "sewer"
    t.boolean "change_use"
    t.string "ccr"
    t.boolean "consider_zoning"
    t.boolean "consider_environment"
    t.boolean "consider_slope"
    t.boolean "consider_other"
    t.boolean "consider_dont_know"
    t.boolean "consider_no"
    t.string "phone"
    t.string "details"
    t.string "referral"
    t.integer "lot_size"
  end

  create_table "messages", force: :cascade do |t|
    t.string "email"
    t.string "name"
    t.string "message"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "subscribes", force: :cascade do |t|
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "refcode"
    t.string "first_name"
    t.string "last_name"
    t.string "phone"
    t.string "address"
    t.integer "getquote_id"
    t.string "zip"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
