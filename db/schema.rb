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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20150624230958) do

  create_table "activities", :force => true do |t|
    t.string   "content"
    t.string   "author"
    t.integer  "loggable_id"
    t.string   "loggable_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "certs", :force => true do |t|
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
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "grade"
    t.integer  "event_id"
    t.string   "certification"
  end

  add_index "certs", ["person_id"], :name => "index_certs_on_person_id"

  create_table "channels", :force => true do |t|
    t.integer  "person_id"
    t.string   "name"
    t.string   "status"
    t.string   "content"
    t.integer  "priority"
    t.string   "category"
    t.string   "carrier"
    t.datetime "last_verified"
    t.string   "usage"
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
    t.boolean  "sms_available", :default => false
    t.string   "type"
  end

  add_index "channels", ["category"], :name => "index_channels_on_category"
  add_index "channels", ["person_id"], :name => "index_channels_on_person_id"
  add_index "channels", ["priority"], :name => "index_channels_on_priority"

  create_table "courses", :force => true do |t|
    t.string   "name"
    t.string   "status"
    t.text     "description"
    t.text     "comments"
    t.string   "category"
    t.integer  "duration"
    t.integer  "term"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "courses_skills", :id => false, :force => true do |t|
    t.integer "course_id"
    t.integer "skill_id"
  end

  add_index "courses_skills", ["course_id", "skill_id"], :name => "index_courses_skills_on_course_id_and_skill_id"

  create_table "events", :force => true do |t|
    t.integer  "course_id"
    t.string   "instructor"
    t.string   "location"
    t.string   "description"
    t.datetime "start_time"
    t.datetime "end_time"
    t.decimal  "duration",    :precision => 7, :scale => 2
    t.string   "category"
    t.string   "status"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.string   "title"
    t.text     "comments"
    t.string   "error_code"
    t.string   "id_code"
  end

  create_table "helpdocs", :force => true do |t|
    t.string   "title"
    t.text     "contents"
    t.string   "help_for_view"
    t.string   "help_for_section"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
  end

  create_table "inspections", :force => true do |t|
    t.integer  "person_id"
    t.datetime "inspection_time"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "status"
  end

  add_index "inspections", ["person_id"], :name => "index_inspections_on_person_id"

  create_table "items", :force => true do |t|
    t.integer  "location_id"
    t.string   "name"
    t.string   "description"
    t.string   "source"
    t.string   "category"
    t.string   "model"
    t.string   "serial1"
    t.integer  "person_id"
    t.date     "purchase_date"
    t.float    "purchase_amt"
    t.date     "sell_date"
    t.float    "sell_amt"
    t.string   "status"
    t.datetime "created_at",                                    :null => false
    t.datetime "updated_at",                                    :null => false
    t.string   "serial2"
    t.string   "grant"
    t.date     "grantstart"
    t.date     "grantexpiration"
    t.string   "icsid"
    t.string   "po_number"
    t.decimal  "value",           :precision => 8, :scale => 2
    t.string   "serial3"
    t.string   "brand"
    t.string   "stock_number"
    t.text     "comments"
  end

  create_table "locations", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.string   "category"
    t.string   "status"
    t.string   "comments"
    t.float    "lat"
    t.float    "lon"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "floor"
    t.string   "container"
    t.string   "street"
    t.string   "city"
    t.string   "state"
    t.string   "zipcode"
  end

  create_table "messages", :force => true do |t|
    t.integer  "recipient_id"
    t.string   "status"
    t.string   "channel"
    t.datetime "processed_at"
    t.string   "processed_by"
    t.string   "slug"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.text     "body"
    t.string   "subject"
  end

  create_table "moves", :force => true do |t|
    t.integer  "item_id"
    t.integer  "locatable_id"
    t.string   "locatable_type"
    t.string   "comments"
    t.string   "reason"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "notifications", :force => true do |t|
    t.integer  "event_id"
    t.integer  "author_id"
    t.string   "status"
    t.string   "channels"
    t.string   "subject"
    t.string   "body"
    t.datetime "sent_at"
    t.text     "comments"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "priority"
    t.string   "event_group"
    t.string   "send_trigger"
    t.integer  "ttl"
  end

  create_table "people", :force => true do |t|
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
    t.string   "blood_type",     :limit => 12
    t.string   "allergies"
    t.string   "passwordhash"
    t.text     "comments"
    t.decimal  "total_hours",                  :precision => 7, :scale => 2
    t.date     "start_date"
    t.date     "end_date"
    t.string   "title"
    t.string   "division1"
    t.string   "division2"
    t.integer  "position",                                                   :default => 30
    t.datetime "created_at",                                                                 :null => false
    t.datetime "updated_at",                                                                 :null => false
    t.integer  "duration"
    t.integer  "title_order"
    t.string   "error_code"
    t.string   "prefix_name"
    t.string   "middlename"
    t.string   "suffix_name"
    t.string   "nickname"
  end

  create_table "people_titles", :id => false, :force => true do |t|
    t.integer "person_id"
    t.integer "title_id"
  end

  add_index "people_titles", ["person_id", "title_id"], :name => "index_people_titles_on_person_id_and_title_id"

  create_table "recipients", :force => true do |t|
    t.integer  "person_id"
    t.integer  "notification_id"
    t.string   "uuid"
    t.string   "status"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
  end

  create_table "repairs", :force => true do |t|
    t.integer  "item_id"
    t.integer  "user_id"
    t.string   "person_id"
    t.string   "category"
    t.date     "service_date"
    t.string   "status"
    t.string   "description"
    t.string   "comments"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "responses", :force => true do |t|
    t.integer  "recipient_id"
    t.string   "intention"
    t.datetime "eta"
    t.datetime "etd"
    t.decimal  "duration",     :precision => 5, :scale => 2
    t.string   "channel"
    t.datetime "created_at",                                 :null => false
    t.datetime "updated_at",                                 :null => false
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "roles", ["name"], :name => "index_roles_on_name"

  create_table "roles_users", :id => false, :force => true do |t|
    t.integer "role_id"
    t.integer "user_id"
  end

  add_index "roles_users", ["role_id", "user_id"], :name => "index_roles_users_on_role_id_and_user_id"

  create_table "skills", :force => true do |t|
    t.string   "name"
    t.string   "status"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "skills_titles", :id => false, :force => true do |t|
    t.integer "skill_id"
    t.integer "title_id"
  end

  add_index "skills_titles", ["skill_id", "title_id"], :name => "index_skills_titles_on_skill_id_and_title_id"

  create_table "timecards", :force => true do |t|
    t.integer  "person_id"
    t.integer  "event_id"
    t.string   "category"
    t.string   "intention"
    t.datetime "intended_start_time"
    t.datetime "intended_end_time"
    t.decimal  "actual_duration",     :precision => 7, :scale => 2
    t.datetime "created_at",                                        :null => false
    t.datetime "updated_at",                                        :null => false
    t.string   "outcome"
    t.datetime "actual_start_time"
    t.datetime "actual_end_time"
    t.decimal  "intended_duration",   :precision => 7, :scale => 2
    t.text     "comments"
    t.string   "error_code"
    t.string   "description"
  end

  create_table "titles", :force => true do |t|
    t.string   "name"
    t.string   "status"
    t.string   "description"
    t.text     "comments"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "failed_attempts",        :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.string   "authentication_token"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "username"
    t.string   "firstname"
    t.string   "lastname"
  end

  add_index "users", ["authentication_token"], :name => "index_users_on_authentication_token", :unique => true
  add_index "users", ["confirmation_token"], :name => "index_users_on_confirmation_token", :unique => true
  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true
  add_index "users", ["unlock_token"], :name => "index_users_on_unlock_token", :unique => true

end
