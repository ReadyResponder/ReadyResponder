class Timeslot < ActiveRecord::Base
  #before_save :pull_from_event
  before_save :calc_durations
  attr_accessible :intention, :outcome, :category, :intended_start_time, :intended_end_time, :actual_start_time, :actual_end_time, :event_id, :person_id
  
  belongs_to :person
  belongs_to :event

  INTENTION_CHOICES = ['Scheduled', 'Volunteered', 'Unavailable']
  OUTCOME_CHOICES = ['Actual', 'Excused', 'AWOL']

  def intended_end_date_cannot_be_before_start
    if ((!intended_end_time.blank?) and (!intended_start_time.blank?)) and intended_end_time < intended_start_time
      errors.add(:intended_end_time, "must be after the start, unless you are the Doctor")
    end
  end
  def actual_end_date_cannot_be_before_start
    if ((!actual_end_time.blank?) and (!actual_start_time.blank?)) and actual_end_time < actual_start_time
      errors.add(:actual_end_time, "must be after the start, unless you are the Doctor")
    end
  end
  validates_presence_of :person_id, :event_id, :intention
  validate :intended_end_date_cannot_be_before_start
  validate :actual_end_date_cannot_be_before_start


  def pull_from_event
      e = self.event || Event.new
      self.start_time = e.start_time if self.start_time.nil?
      self.end_time = e.end_time if self.end_time.nil?
      self.category = e.category if self.category.nil?
  end
  
  def calc_durations
    if !(intended_start_time.blank?) and !(intended_end_time.blank?)
      self.intended_duration = ((intended_end_time - intended_start_time) / 1.hour).round(2) || 0
    end 
    if !(actual_start_time.blank?) and !(actual_end_time.blank?)
      self.actual_duration = ((actual_end_time - actual_start_time) / 1.hour).round(2) || 0
    end 
  end
end