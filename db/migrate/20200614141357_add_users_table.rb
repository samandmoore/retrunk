class AddUsersTable < ActiveRecord::Migration[6.0]
  def change
    enable_extension "pgcrypto"
    enable_extension "plpgsql"
    enable_extension "uuid-ossp"

    create_table "users", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
      t.string "email", default: "", null: false
      t.string "name", default: "", null: false
      t.string "github_username", default: "", null: false
      t.integer "sign_in_count", default: 0, null: false
      t.datetime "current_sign_in_at"
      t.datetime "last_sign_in_at"
      t.string "current_sign_in_ip"
      t.string "last_sign_in_ip"
      t.string "provider"
      t.string "uid"
      t.string "github_oauth_token"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["email"], name: "index_users_on_email", unique: true
      t.index ["uid"], name: "index_users_on_uid", unique: true
    end
  end
end
