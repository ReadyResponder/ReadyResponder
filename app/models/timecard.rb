class Timecard < ActiveRecord::Base
  before_save :calc_durations
  attr_accessible :intention, :intended_start_time, :intended_end_time,
                  :outcome, :actual_start_time, :actual_end_time, :event_id, :person_id, :category, :description

  belongs_to :person

  INTENTION_CHOICES = ['Unknown', 'Available', 'Scheduled','Not Needed']
  OUTCOME_CHOICES = ["Not Needed", 'Worked', 'Unavailable', 'AWOL', 'Vacation']

  validates_presence_of :person_id

  validates_chronology :intended_start_time, :intended_end_time
  validates_chronology :actual_start_time, :actual_end_time

  #validate :has_no_duplicate_timecard

  def self.available
    where(intention: "Available", outcome:['', nil])
  end

  def self.scheduled
    #Postgres distinguishes between null and an empty string, others do not
    where(intention: "Scheduled", outcome:['', nil])
  end

  def self.unavailable
    where(intention: "Unavailable")
  end

  def self.working
    where(outcome: "Worked", actual_end_time: nil)
  end

  def self.worked
    where(outcome: "Worked").where(Timecard.arel_table['actual_end_time'].not_eq(nil))
  end

def find_duplicate_timecards
  margin = 30
  query = Timecard.where(person_id: self.person_id)
  if self.intended_start_time.is_a?(Time) && self.intended_end_time.is_a?(Time)
    true_start = self.intended_start_time
    fuzzy_start = (self.intended_start_time - margin.minutes)
    fuzzy_end = (self.intended_end_time + margin.minutes)
    query = query.where('(? > intended_start_time AND ? < intended_end_time) OR (intended_start_time BETWEEN ? AND ?)',
                                                true_start,fuzzy_start, fuzzy_start, fuzzy_end)
  end

  if self.actual_start_time.is_a?(Time) && self.actual_end_time.is_a?(Time)
    true_start = self.actual_start_time
    fuzzy_start = (self.actual_start_time - margin.minutes)
    fuzzy_end = (self.actual_end_time + margin.minutes)
    query = query.where('(? > actual_start_time AND ? < actual_end_time) OR (actual_start_time BETWEEN ? AND ?)',
                                                true_start,fuzzy_start, fuzzy_start, fuzzy_end)
  end

  if self.new_record? #then self.id will be nil
    query
  else #if it's not a new record, I need to filter out itself
    query.where("id != ?", self.id)
  end
end

private
  def has_no_duplicate_timecard
    if find_duplicate_timecards.count > 0
      errors.add :base, "Duplicate timecard found, please edit that one instead"
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
