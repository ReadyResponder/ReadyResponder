class ChangeAttendancesToTimeslots < ActiveRecord::Migration[4.2]
  def up
  	 drop_table :attendances
  	 create_table :timeslots do |t|
		t.integer  "person_id"
		t.integer  "event_id"
		t.string   "category"
		t.string   "status"
		t.datetime "start_time"
		t.datetime "end_time"
		t.decimal  "duration",       :precision => 7, :scale => 2
		t.datetime "created_at",     :null => false
		t.datetime "updated_at",     :null => false
    end
  end

  def down
  end
end
