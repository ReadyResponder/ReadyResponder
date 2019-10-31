class CreatePeople < ActiveRecord::Migration[4.2]
  def change
    create_table :people do |t|
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
    t.decimal  "total_hours", :precision => 7, :scale => 2
    t.date     "start_date"
    t.date     "end_date"
    t.string   "title"
    t.string   "division1"
    t.string   "division2"
    t.integer  "position", :default => 30
    t.timestamps
    end
  end
end
