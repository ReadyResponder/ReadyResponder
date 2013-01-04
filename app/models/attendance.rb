class Attendance < ActiveRecord::Base
  attr_accessible :category, :duration, :end_time, :est_end_time, :est_start_time, :event_id, :person_id, :start_time
end
