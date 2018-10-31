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

ActiveRecord::Schema.define(version: 2018_10_18_140320) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "activities", id: :serial, force: :cascade do |t|
    t.string "content"
    t.string "author"
    t.integer "loggable_id"
    t.string "loggable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "assignments", id: :serial, force: :cascade do |t|
    t.integer "person_id"
    t.integer "requirement_id"
    t.datetime "start_time", null: false
    t.datetime "end_time", null: false
    t.string "status"
    t.decimal "duration", precision: 7, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["person_id"], name: "index_assignments_on_person_id"
    t.index ["requirement_id"], name: "index_assignments_on_requirement_id"
  end

  create_table "availabilities", id: :serial, force: :cascade do |t|
    t.datetime "start_time"
    t.datetime "end_time"
    t.string "status"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "person_id"
    t.index ["person_id"], name: "index_availabilities_on_person_id"
  end

  create_table "certs", id: :serial, force: :cascade do |t|
    t.integer "person_id"
    t.integer "course_id"
    t.string "status"
    t.string "category"
    t.string "level"
    t.string "cert_number"
    t.date "issued_date"
    t.date "expiration_date"
    t.text "comments"
    t.integer "updated_by"
    t.integer "created_by"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "grade"
    t.integer "event_id"
    t.string "certification"
    t.index ["person_id"], name: "index_certs_on_person_id"
  end

  create_table "channels", id: :serial, force: :cascade do |t|
    t.integer "person_id"
    t.string "name"
    t.string "status"
    t.string "content"
    t.integer "priority"
    t.string "category"
    t.string "carrier"
    t.datetime "last_verified"
    t.string "usage"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "channel_type"
    t.boolean "sms_available", default: false
    t.string "type"
    t.index ["category"], name: "index_channels_on_category"
    t.index ["person_id"], name: "index_channels_on_person_id"
    t.index ["priority"], name: "index_channels_on_priority"
  end

  create_table "comments", id: :serial, force: :cascade do |t|
    t.string "title", limit: 50, default: ""
    t.text "description"
    t.integer "commentable_id"
    t.string "commentable_type"
    t.integer "person_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "courses", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "status"
    t.text "description"
    t.text "comments"
    t.string "category"
    t.integer "duration"
    t.integer "term"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "courses_skills", id: false, force: :cascade do |t|
    t.integer "course_id"
    t.integer "skill_id"
    t.index ["course_id", "skill_id"], name: "index_courses_skills_on_course_id_and_skill_id"
  end

  create_table "departments", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "shortname", null: false
    t.string "status"
    t.integer "contact_id"
    t.text "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "division1"
    t.string "division2"
    t.boolean "manage_people", default: false
    t.boolean "manage_items", default: false
  end

  create_table "departments_events", id: false, force: :cascade do |t|
    t.integer "department_id", null: false
    t.integer "event_id", null: false
    t.index ["department_id", "event_id"], name: "index_departments_events_on_department_id_and_event_id"
    t.index ["event_id", "department_id"], name: "index_departments_events_on_event_id_and_department_id"
  end

  create_table "departments_notifications", id: false, force: :cascade do |t|
    t.integer "department_id"
    t.integer "notification_id"
    t.index ["department_id", "notification_id"], name: "departments_notifications_index"
  end

  create_table "events", id: :serial, force: :cascade do |t|
    t.integer "course_id"
    t.string "instructor"
    t.string "location"
    t.string "description"
    t.datetime "start_time"
    t.datetime "end_time"
    t.integer "duration"
    t.string "category"
    t.string "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "title"
    t.text "comments"
    t.string "error_code"
    t.string "id_code"
    t.boolean "is_template", default: false
    t.integer "template_id"
    t.string "min_title", null: false
  end

  create_table "grants", id: :serial, force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "start_date"
    t.datetime "end_date"
    t.string "status"
  end

  create_table "helpdocs", id: :serial, force: :cascade do |t|
    t.string "title"
    t.text "contents"
    t.string "help_for_view"
    t.string "help_for_section"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "inspection_questions", id: :serial, force: :cascade do |t|
    t.integer "inspection_id"
    t.integer "question_id"
    t.string "prompt"
    t.string "response"
    t.text "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["inspection_id"], name: "index_inspection_questions_on_inspection_id"
    t.index ["question_id"], name: "index_inspection_questions_on_question_id"
  end

  create_table "inspections", id: :serial, force: :cascade do |t|
    t.integer "item_id"
    t.integer "person_id"
    t.datetime "inspection_date"
    t.integer "mileage"
    t.string "repair_needed"
    t.string "status"
    t.text "comments"
    t.string "category"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["item_id"], name: "index_inspections_on_item_id"
  end

  create_table "item_categories", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "status"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "item_types", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "status"
    t.string "is_groupable"
    t.string "is_a_group"
    t.integer "parent_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "item_category_id"
    t.string "description"
    t.string "item_type_image"
  end

  create_table "items", id: :serial, force: :cascade do |t|
    t.integer "location_id"
    t.string "name"
    t.string "description"
    t.string "source_data"
    t.string "category"
    t.string "model"
    t.date "purchase_date"
    t.float "purchase_amt"
    t.date "sell_date"
    t.float "sell_amt"
    t.string "status"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "grant"
    t.date "grantstart"
    t.date "grantexpiration"
    t.string "icsid"
    t.string "po_number"
    t.decimal "value", precision: 8, scale: 2
    t.string "brand"
    t.string "stock_number"
    t.text "comments"
    t.string "item_image"
    t.integer "owner_id"
    t.integer "department_id"
    t.integer "resource_type_id"
    t.integer "item_type_id"
    t.string "condition"
    t.integer "qty"
    t.integer "grant_id"
    t.integer "vendor_id"
    t.index ["vendor_id"], name: "index_items_on_vendor_id"
  end

  create_table "locations", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "category"
    t.string "status"
    t.string "comments"
    t.float "lat"
    t.float "lon"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "floor"
    t.string "container"
    t.string "street"
    t.string "city"
    t.string "state"
    t.string "zipcode"
    t.integer "department_id"
  end

  create_table "messages", id: :serial, force: :cascade do |t|
    t.string "subject"
    t.string "status"
    t.string "body"
    t.datetime "sent_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "recipient_id"
    t.integer "channel_id"
  end

  create_table "moves", id: :serial, force: :cascade do |t|
    t.integer "item_id"
    t.integer "locatable_id"
    t.string "locatable_type"
    t.string "comments"
    t.string "reason"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notifications", id: :serial, force: :cascade do |t|
    t.integer "event_id"
    t.integer "author_id"
    t.string "status"
    t.integer "time_to_live"
    t.integer "interval"
    t.integer "iterations_to_escalation"
    t.datetime "scheduled_start_time"
    t.datetime "start_time"
    t.text "channels"
    t.text "groups"
    t.text "departments"
    t.text "divisions"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "subject"
    t.text "body"
    t.string "purpose"
    t.string "event_statuses"
    t.string "event_assigned"
    t.string "id_code"
    t.text "individuals"
    t.index ["event_id"], name: "index_notifications_on_event_id"
  end

  create_table "people", id: :serial, force: :cascade do |t|
    t.string "firstname"
    t.string "lastname"
    t.string "status"
    t.string "middleinitial"
    t.date "date_of_birth"
    t.string "memberID"
    t.string "orgcode"
    t.integer "org_id"
    t.string "icsid"
    t.string "eligibility"
    t.string "deployable"
    t.string "gender"
    t.string "street"
    t.string "city"
    t.string "state"
    t.string "zipcode", limit: 10
    t.string "license_number"
    t.integer "weight"
    t.integer "height"
    t.string "eyes"
    t.string "blood_type", limit: 12
    t.string "allergies"
    t.string "passwordhash"
    t.text "old_comments"
    t.decimal "total_hours", precision: 7, scale: 2
    t.date "start_date"
    t.date "end_date"
    t.string "title"
    t.string "division1"
    t.string "division2"
    t.integer "position", default: 30
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "duration"
    t.integer "title_order", null: false
    t.string "error_code"
    t.string "prefix_name"
    t.string "middlename"
    t.string "suffix_name"
    t.string "nickname"
    t.string "portrait"
    t.date "application_date"
    t.integer "department_id"
  end

  create_table "people_titles", id: false, force: :cascade do |t|
    t.integer "person_id"
    t.integer "title_id"
    t.index ["person_id", "title_id"], name: "index_people_titles_on_person_id_and_title_id"
  end

  create_table "questions", id: :serial, force: :cascade do |t|
    t.string "prompt"
    t.string "response_choices"
    t.string "category"
    t.string "status"
    t.text "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "recipients", id: :serial, force: :cascade do |t|
    t.integer "notification_id"
    t.integer "person_id"
    t.text "status"
    t.text "response_channel"
    t.datetime "response_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "repairs", id: :serial, force: :cascade do |t|
    t.integer "item_id"
    t.integer "user_id"
    t.string "person_id"
    t.string "category"
    t.date "service_date"
    t.string "status"
    t.string "description"
    t.string "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.decimal "cost", precision: 8, scale: 2
    t.string "condition"
  end

  create_table "requirements", id: :serial, force: :cascade do |t|
    t.integer "task_id"
    t.integer "skill_id"
    t.integer "title_id"
    t.integer "priority"
    t.integer "minimum_people"
    t.integer "maximum_people"
    t.integer "desired_people"
    t.boolean "floating"
    t.boolean "optional"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "auto_assign", default: false
    t.index ["skill_id"], name: "index_requirements_on_skill_id"
    t.index ["task_id"], name: "index_requirements_on_task_id"
    t.index ["title_id"], name: "index_requirements_on_title_id"
  end

  create_table "resource_types", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "status"
    t.text "description"
    t.string "fema_code"
    t.string "fema_kind"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["name"], name: "index_roles_on_name"
  end

  create_table "roles_users", id: false, force: :cascade do |t|
    t.integer "role_id"
    t.integer "user_id"
    t.index ["role_id", "user_id"], name: "index_roles_users_on_role_id_and_user_id"
  end

  create_table "settings", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "key"
    t.string "value"
    t.string "category"
    t.string "status"
    t.boolean "required", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "skills", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "skills_titles", id: false, force: :cascade do |t|
    t.integer "skill_id"
    t.integer "title_id"
    t.index ["skill_id", "title_id"], name: "index_skills_titles_on_skill_id_and_title_id"
  end

  create_table "system_activity_logs", id: :serial, force: :cascade do |t|
    t.integer "user_id"
    t.text "message", null: false
    t.string "category", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tasks", id: :serial, force: :cascade do |t|
    t.integer "event_id"
    t.string "title"
    t.text "description"
    t.string "street"
    t.string "city"
    t.string "state"
    t.string "zipcode"
    t.float "latitude"
    t.float "longitude"
    t.datetime "start_time"
    t.datetime "end_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "location"
    t.integer "priority"
    t.string "status"
    t.index ["event_id"], name: "index_tasks_on_event_id"
  end

  create_table "timecards", id: :serial, force: :cascade do |t|
    t.integer "person_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "start_time"
    t.datetime "end_time"
    t.decimal "duration", precision: 7, scale: 2
    t.text "comments"
    t.string "error_code"
    t.string "description"
    t.string "status"
  end

  create_table "titles", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "status"
    t.string "description"
    t.text "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "unique_ids", id: :serial, force: :cascade do |t|
    t.integer "item_id"
    t.string "status"
    t.string "category"
    t.string "value"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["item_id"], name: "index_unique_ids_on_item_id"
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0
    t.string "unlock_token"
    t.datetime "locked_at"
    t.string "authentication_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "username"
    t.string "firstname"
    t.string "lastname"
    t.index ["authentication_token"], name: "index_users_on_authentication_token", unique: true
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  create_table "vendors", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "street"
    t.string "city"
    t.string "state"
    t.string "zipcode"
    t.string "status"
    t.text "comments"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "versions", id: :serial, force: :cascade do |t|
    t.string "item_type", null: false
    t.integer "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.text "object"
    t.datetime "created_at"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

  add_foreign_key "assignments", "people"
  add_foreign_key "assignments", "requirements"
  add_foreign_key "notifications", "events"
  add_foreign_key "requirements", "skills"
  add_foreign_key "requirements", "tasks"
  add_foreign_key "requirements", "titles"
  add_foreign_key "tasks", "events"
end
