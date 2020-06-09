ActiveRecord::Schema.define(version: 2017_05_09_232014) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "webuser", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
