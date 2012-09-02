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

ActiveRecord::Schema.define(:version => 20120902071807) do

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

  create_table "courses", :force => true do |t|
    t.string   "title"
    t.string   "status"
    t.text     "description"
    t.text     "comments"
    t.string   "category"
    t.integer  "duration"
    t.integer  "term"
    t.string   "required_for_pd"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.string   "required_for_cert"
    t.string   "required_for_sar"
  end

  create_table "courses_skills", :id => false, :force => true do |t|
    t.integer "course_id"
    t.integer "skill_id"
  end

  add_index "courses_skills", ["course_id", "skill_id"], :name => "index_courses_skills_on_course_id_and_skill_id"

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
  end

  create_table "skills", :force => true do |t|
    t.string   "title"
    t.string   "status"
    t.boolean  "required_for_pd"
    t.boolean  "required_for_cert"
    t.boolean  "required_for_sar"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

end
