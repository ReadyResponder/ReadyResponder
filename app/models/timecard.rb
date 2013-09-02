class Timecard < ActiveRecord::Base
  before_save :pull_defaults_from_event
  before_save :calc_durations
  attr_accessible :intention, :outcome, :category, :intended_start_time, :intended_end_time, :actual_start_time, :actual_end_time, :event_id, :person_id
  
  belongs_to :person
  belongs_to :event

  INTENTION_CHOICES = ['Available', 'Scheduled', 'Unavailable', "Vacation"]
  OUTCOME_CHOICES = ['Worked', "Not Needed", "Excused", "Unexcused", 'AWOL', "Vacation Approved", "Vacation Denied"]

  def intended_end_date_cannot_be_before_intended_start
    if ((!intended_end_time.blank?) and (!intended_start_time.blank?)) and intended_end_time < intended_start_time
      errors.add(:intended_end_time, "must be after the start, unless you are the Doctor")
    end
  end

  def actual_end_date_cannot_be_before_actual_start
    if ((!actual_end_time.blank?) and (!actual_start_time.blank?)) and actual_end_time < actual_start_time
      errors.add :actual_end_time, "must be after the start, unless you are the Doctor"
    end
  end
  def has_a_duplicate_timecard
    if find_duplicate_timecards.count > 0 
      errors.add :base, "Duplicate timecard found, please edit that one instead"
    end
  end

  validates_presence_of :person_id, :event_id
  validate :intended_end_date_cannot_be_before_intended_start
  validate :actual_end_date_cannot_be_before_actual_start
  validate :has_a_duplicate_timecard

  def self.available
    where(intention: "Available")
  end
  def self.scheduled
    where(intention: "Scheduled", outcome: nil)
  end
  def self.unavailable
    where(outcome: "Unavailable")
  end
  def self.worked
    where(outcome: "Worked")
  end

def find_duplicate_timecards
  margin = 30
  unless self.intended_start_time.blank?
    intended_edge1 = (self.intended_start_time - margin.minutes)
    intended_edge2 = (self.intended_start_time + margin.minutes)
  end
  unless self.actual_start_time.blank?
    actual_edge1 = (self.actual_start_time - margin.minutes)
    actual_edge2 = (self.actual_start_time + margin.minutes)
  end
  query = Timecard.where(event_id: self.event_id, person_id: self.person_id)
  query = query.where('(intended_start_time BETWEEN ? AND ?) OR (actual_start_time BETWEEN ? AND ?)',
                                                intended_edge1,intended_edge2, actual_edge1, actual_edge2) 
  if self.new_record? #then self.id will be nil
    query
  else #if it's not a new record, I need to filter out itself
    query.where("id != ?", self.id)
  end
end

private
  def pull_defaults_from_event
      event = self.event || Event.new
      self.category = event.category if self.category.nil?
      if self.outcome == "Worked" 
        self.actual_start_time = event.start_time if self.actual_start_time.nil?
        self.actual_end_time = event.end_time if self.actual_end_time.nil? & event.status == "Complete"
      end
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