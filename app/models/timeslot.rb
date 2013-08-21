class Timeslot < ActiveRecord::Base
  before_save :pull_from_event
  before_save :calc_duration
  attr_accessible :category, :start_time, :end_time, :event_id, :person_id
  
  belongs_to :person
  belongs_to :event
  
  def end_date_cannot_be_before_start
    if ((!end_time.blank?) and (!start_time.blank?)) and end_time < start_time
      errors.add(:end_time, "must be after the start, unless you are the Doctor")
    end
  end
  validates_presence_of :person_id, :event_id
  #validates_datetime :finish_time, :after => :start_time # Method symbol
  validate :end_date_cannot_be_before_start


  def pull_from_event
      e = self.event || Event.new
      self.start_time = e.start_time if self.start_time.nil?
      self.end_time = e.end_time if self.end_time.nil?
      self.category = e.category if self.category.nil?
  end
  
  def calc_duration
    if !(start_time.blank?) and !(end_time.blank?)
      self.duration = ((end_time - start_time) / 1.hour).round(2) || 0
    end 
  end
end