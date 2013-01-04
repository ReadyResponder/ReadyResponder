class Attendance < ActiveRecord::Base
  before_save :pull_from_event
  attr_accessible :category, :duration, :end_time, :est_end_time, :est_start_time, :event_id, :person_id, :start_time
  
  belongs_to :person
  belongs_to :event
  
  def pull_from_event
      e = self.event || Event.new
      self.duration = e.duration if self.duration.nil?
      self.start_time = e.start_date if self.start_time.nil?
      self.end_time = e.end_date if self.end_time.nil?
  end
  
end  #of class
