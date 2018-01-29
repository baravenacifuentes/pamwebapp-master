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

ActiveRecord::Schema.define(version: 20171107153117) do

  create_table "components", force: :cascade do |t|
    t.string   "name"
    t.integer  "gear_id"
    t.integer  "worst_sample_id"
    t.datetime "worst_deadline"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["gear_id"], name: "index_components_on_gear_id"
  end

  create_table "gears", force: :cascade do |t|
    t.integer  "type_id"
    t.string   "name"
    t.integer  "worst_sample_id"
    t.datetime "worst_deadline"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["type_id"], name: "index_gears_on_type_id"
  end

  create_table "lubricants", force: :cascade do |t|
    t.string   "name"
    t.integer  "max_hours"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.string   "resource_type"
    t.integer  "resource_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["name"], name: "index_roles_on_name"
  end

  create_table "sample_variables", force: :cascade do |t|
    t.float    "value"
    t.integer  "sample_id"
    t.integer  "variable_id"
    t.integer  "state",       default: 0
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["sample_id"], name: "index_sample_variables_on_sample_id"
    t.index ["variable_id"], name: "index_sample_variables_on_variable_id"
  end

  create_table "samples", force: :cascade do |t|
    t.string   "sample_code"
    t.string   "lab_code"
    t.integer  "unit_id"
    t.date     "taked_at"
    t.date     "received_at"
    t.date     "reported_at"
    t.integer  "state",       default: 0
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.index ["unit_id"], name: "index_samples_on_unit_id"
  end

  create_table "types", force: :cascade do |t|
    t.string   "type"
    t.string   "name"
    t.integer  "worst_sample_id"
    t.datetime "worst_deadline"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "units", force: :cascade do |t|
    t.integer  "component_id"
    t.integer  "lubricant_id"
    t.string   "name"
    t.integer  "worst_sample_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["component_id"], name: "index_units_on_component_id"
    t.index ["lubricant_id"], name: "index_units_on_lubricant_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0,  null: false
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer  "invitation_limit"
    t.integer  "invited_by_id"
    t.string   "invited_by_type"
    t.string   "name"
    t.string   "surname"
    t.string   "second_surname"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token"
    t.index ["email"], name: "index_users_on_email"
    t.index ["invitation_token"], name: "index_users_on_invitation_token"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token"
    t.index ["unlock_token"], name: "index_users_on_unlock_token"
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
  end

  create_table "variables", force: :cascade do |t|
    t.float    "min"
    t.float    "mid"
    t.float    "max"
    t.integer  "lubricant_id"
    t.integer  "type_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["lubricant_id"], name: "index_variables_on_lubricant_id"
    t.index ["type_id"], name: "index_variables_on_type_id"
  end

end
