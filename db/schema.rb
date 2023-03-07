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

ActiveRecord::Schema.define(version: 2021_05_18_150814) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "contracts", force: :cascade do |t|
    t.bigint "customer_id"
    t.string "instance_reason"
    t.string "customer_class"
    t.string "contract_number"
    t.string "explanation"
    t.string "prioritization"
    t.string "monitoring"
    t.string "gideon_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "date_of_consideration"
    t.index ["customer_id"], name: "index_contracts_on_customer_id"
  end

  create_table "criterions", force: :cascade do |t|
    t.string "content"
    t.string "column"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "customers", force: :cascade do |t|
    t.string "name"
    t.string "client_number"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_customers_on_user_id"
  end

  create_table "delegations", force: :cascade do |t|
    t.bigint "assistant_id"
    t.bigint "agent_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["agent_id"], name: "index_delegations_on_agent_id"
    t.index ["assistant_id"], name: "index_delegations_on_assistant_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false, null: false
    t.boolean "authorized", default: false, null: false
    t.string "pseudo"
    t.boolean "assistant", default: false, null: false
    t.boolean "super_admin", default: false, null: false
    t.string "first_name"
    t.string "last_name"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "contracts", "customers"
  add_foreign_key "customers", "users"
  add_foreign_key "delegations", "users", column: "agent_id"
  add_foreign_key "delegations", "users", column: "assistant_id"
end
