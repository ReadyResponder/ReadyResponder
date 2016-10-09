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

ActiveRecord::Schema.define(version: 20161008061337) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", force: :cascade do |t|
    t.string   "content"
    t.string   "author"
    t.integer  "loggable_id"
    t.string   "loggable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "availabilities", force: :cascade do |t|
    t.datetime "start_time"
    t.datetime "end_time"
    t.string   "status"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "person_id"
  end

  add_index "availabilities", ["person_id"], name: "index_availabilities_on_person_id", using: :btree

  create_table "certs", force: :cascade do |t|
    t.integer  "person_id"
    t.integer  "course_id"
    t.string   "status"
    t.string   "category"
    t.string   "level"
    t.string   "cert_number"
    t.date     "issued_date"
    t.date     "expiration_date"
    t.text     "comments"
    t.integer  "updated_by"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "grade"
    t.integer  "event_id"
    t.string   "certification"
  end

  add_index "certs", ["person_id"], name: "index_certs_on_person_id", using: :btree

  create_table "channels", force: :cascade do |t|
    t.integer  "person_id"
    t.string   "name"
    t.string   "status"
    t.string   "content"
    t.integer  "priority"
    t.string   "category"
    t.string   "carrier"
    t.datetime "last_verified"
    t.string   "usage"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "channel_type"
    t.boolean  "sms_available", default: false
    t.string   "type"
  end

  add_index "channels", ["category"], name: "index_channels_on_category", using: :btree
  add_index "channels", ["person_id"], name: "index_channels_on_person_id", using: :btree
  add_index "channels", ["priority"], name: "index_channels_on_priority", using: :btree

  create_table "courses", force: :cascade do |t|
    t.string   "name"
    t.string   "status"
    t.text     "description"
    t.text     "comments"
    t.string   "category"
    t.integer  "duration"
    t.integer  "term"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "courses_skills", id: false, force: :cascade do |t|
    t.integer "course_id"
    t.integer "skill_id"
  end

  add_index "courses_skills", ["course_id", "skill_id"], name: "index_courses_skills_on_course_id_and_skill_id", using: :btree

  create_table "departments", force: :cascade do |t|
    t.string   "name"
    t.string   "shortname"
    t.string   "status"
    t.integer  "contact_id"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "division1"
    t.string   "division2"
  end

  create_table "events", force: :cascade do |t|
    t.integer  "course_id"
    t.string   "instructor"
    t.string   "location"
    t.string   "description"
    t.datetime "start_time"
    t.datetime "end_time"
    t.decimal  "duration",    precision: 7, scale: 2
    t.string   "category"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "title"
    t.text     "comments"
    t.string   "error_code"
    t.string   "id_code"
  end

  create_table "helpdocs", force: :cascade do |t|
    t.string   "title"
    t.text     "contents"
    t.string   "help_for_view"
    t.string   "help_for_section"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "inspection_questions", force: :cascade do |t|
    t.integer  "inspection_id"
    t.integer  "question_id"
    t.string   "prompt"
    t.string   "response"
    t.text     "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "inspection_questions", ["inspection_id"], name: "index_inspection_questions_on_inspection_id", using: :btree
  add_index "inspection_questions", ["question_id"], name: "index_inspection_questions_on_question_id", using: :btree

  create_table "inspections", force: :cascade do |t|
    t.integer  "item_id"
    t.integer  "person_id"
    t.datetime "inspection_date"
    t.integer  "mileage"
    t.string   "repair_needed"
    t.string   "status"
    t.text     "comments"
    t.string   "category"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "inspections", ["item_id"], name: "index_inspections_on_item_id", using: :btree

  create_table "item_types", force: :cascade do |t|
    t.string   "name"
    t.string   "status"
    t.string   "is_groupable"
    t.string   "is_a_group"
    t.integer  "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "items", force: :cascade do |t|
    t.integer  "location_id"
    t.string   "name"
    t.string   "description"
    t.string   "source"
    t.string   "category"
    t.string   "model"
    t.date     "purchase_date"
    t.float    "purchase_amt"
    t.date     "sell_date"
    t.float    "sell_amt"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "grant"
    t.date     "grantstart"
    t.date     "grantexpiration"
    t.string   "icsid"
    t.string   "po_number"
    t.decimal  "value",            precision: 8, scale: 2
    t.string   "brand"
    t.string   "stock_number"
    t.text     "comments"
    t.string   "item_image"
    t.integer  "owner_id"
    t.integer  "department_id"
    t.integer  "resource_type_id"
    t.integer  "item_type_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.string   "category"
    t.string   "status"
    t.string   "comments"
    t.float    "lat"
    t.float    "lon"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "floor"
    t.string   "container"
    t.string   "street"
    t.string   "city"
    t.string   "state"
    t.string   "zipcode"
    t.integer  "department_id"
  end

  create_table "messages", force: :cascade do |t|
    t.string   "subject"
    t.string   "status"
    t.string   "body"
    t.string   "channels"
    t.datetime "sent_at"
    t.integer  "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "moves", force: :cascade do |t|
    t.integer  "item_id"
    t.integer  "locatable_id"
    t.string   "locatable_type"
    t.string   "comments"
    t.string   "reason"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "people", force: :cascade do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.string   "status"
    t.string   "middleinitial"
    t.date     "date_of_birth"
    t.string   "memberID"
    t.string   "orgcode"
    t.integer  "org_id"
    t.string   "icsid"
    t.string   "eligibility"
    t.string   "deployable"
    t.string   "gender"
    t.string   "street"
    t.string   "city"
    t.string   "state"
    t.string   "zipcode"
    t.string   "license_number"
    t.string   "department"
    t.integer  "weight"
    t.integer  "height"
    t.string   "eyes"
    t.string   "blood_type",       limit: 12
    t.string   "allergies"
    t.string   "passwordhash"
    t.text     "comments"
    t.decimal  "total_hours",                 precision: 7, scale: 2
    t.date     "start_date"
    t.date     "end_date"
    t.string   "title"
    t.string   "division1"
    t.string   "division2"
    t.integer  "position",                                            default: 30
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "duration"
    t.integer  "title_order"
    t.string   "error_code"
    t.string   "prefix_name"
    t.string   "middlename"
    t.string   "suffix_name"
    t.string   "nickname"
    t.string   "portrait"
    t.date     "application_date"
  end

  create_table "people_titles", id: false, force: :cascade do |t|
    t.integer "person_id"
    t.integer "title_id"
  end

  add_index "people_titles", ["person_id", "title_id"], name: "index_people_titles_on_person_id_and_title_id", using: :btree

  create_table "questions", force: :cascade do |t|
    t.string   "prompt"
    t.string   "response_choices"
    t.string   "category"
    t.string   "status"
    t.text     "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "repairs", force: :cascade do |t|
    t.integer  "item_id"
    t.integer  "user_id"
    t.string   "person_id"
    t.string   "category"
    t.date     "service_date"
    t.string   "status"
    t.string   "description"
    t.string   "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal  "cost",         precision: 8, scale: 2
  end

  create_table "resource_types", force: :cascade do |t|
    t.string   "name"
    t.string   "status"
    t.text     "description"
    t.string   "fema_code"
    t.string   "fema_kind"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "roles_users", id: false, force: :cascade do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  add_index "roles_users", ["role_id", "user_id"], name: "index_roles_users_on_role_id_and_user_id", using: :btree

  create_table "skills", force: :cascade do |t|
    t.string   "name"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "skills_titles", id: false, force: :cascade do |t|
    t.integer "skill_id"
    t.integer "title_id"
  end

  add_index "skills_titles", ["skill_id", "title_id"], name: "index_skills_titles_on_skill_id_and_title_id", using: :btree

  create_table "tasks", force: :cascade do |t|
    t.integer  "event_id"
    t.string   "title"
    t.text     "description"
    t.string   "street"
    t.string   "city"
    t.string   "state"
    t.string   "zipcode"
    t.float    "latitude"
    t.float    "longitude"
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "tasks", ["event_id"], name: "index_tasks_on_event_id", using: :btree

  create_table "timecards", force: :cascade do |t|
    t.integer  "person_id"
    t.integer  "event_id"
    t.string   "category"
    t.string   "intention"
    t.datetime "intended_start_time"
    t.datetime "intended_end_time"
    t.decimal  "actual_duration",     precision: 7, scale: 2
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.string   "outcome"
    t.datetime "actual_start_time"
    t.datetime "actual_end_time"
    t.decimal  "intended_duration",   precision: 7, scale: 2
    t.text     "comments"
    t.string   "error_code"
    t.string   "description"
  end

  create_table "titles", force: :cascade do |t|
    t.string   "name"
    t.string   "status"
    t.string   "description"
    t.text     "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "unique_ids", force: :cascade do |t|
    t.integer  "item_id"
    t.string   "status"
    t.string   "category"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "unique_ids", ["item_id"], name: "index_unique_ids_on_item_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        default: 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "authentication_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
    t.string   "firstname"
    t.string   "lastname"
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", unique: true, using: :btree
  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["unlock_token"], name: "index_users_on_unlock_token", unique: true, using: :btree

  add_foreign_key "tasks", "events"
end
