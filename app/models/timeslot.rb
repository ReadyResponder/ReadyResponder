class Timeslot < ActiveRecord::Base
  #before_save :pull_from_event
  before_save :calc_durations
  attr_accessible :intention, :outcome, :category, :intended_start_time, :intended_end_time, :actual_start_time, :actual_end_time, :event_id, :person_id
  
  belongs_to :person
  belongs_to :event

  INTENTION_CHOICES = ['Available', 'Scheduled', 'Unavailable', "Vacation"]
  OUTCOME_CHOICES = ['Worked', "Not Needed", "Excused", "Unexcused", 'AWOL', "Vacation Approved", "Vacation Denied"]

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

  validates_presence_of :person_id, :event_id
  validate :intended_end_date_cannot_be_before_start
  validate :actual_end_date_cannot_be_before_start

  def self.available
    where(intention: "Available")
  end
  def self.scheduled
    where(intention: "Scheduled", outcome: nil)
  end
  def self.unavailable
    where(intention: "Unavailable")
  end
  def self.worked
    where(outcome: "Worked")
  end

private
  def pull_intention_from_event
      event = self.event || Event.new
      self.intended_start_time = event.start_time if self.intended_start_time.nil?
      self.intended_end_time = event.end_time if self.intended_end_time.nil?
      self.category = event.category if self.category.nil?
  end
  
  def calc_durations
    if intended_start_time.blank? or intended_end_time.blank?
      self.intended_duration = 0
    else
      self.intended_duration = ((intended_end_time - intended_start_time) / 1.hour).round(2) || 0
    end 
    if actual_start_time.blank? or actual_end_time.blank?
      self.actual_duration = 0
    else
      self.actual_duration = ((actual_end_time - actual_start_time) / 1.hour).round(2) || 0
    end 
  end
end