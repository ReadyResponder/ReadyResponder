class Timeslot < ActiveRecord::Base
  before_save :pull_from_event
  before_save :calc_duration
  attr_accessible :category, :duration, :start_time, :end_time, :event_id, :person_id
  
  belongs_to :person
  belongs_to :event
  
  def pull_from_event
      e = self.event || Event.new
      self.duration = e.duration if self.duration.nil?
      self.start_time = e.start_time if self.start_time.nil?
      self.end_time = e.end_time if self.end_time.nil?
  end
  
  def calc_duration
    unless start_time.blank? || end_time.blank?
      self.duration = (end_time - start_time) / 3600 || 0
    end 
  end

end  #of class