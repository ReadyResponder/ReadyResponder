class Timecard < ApplicationRecord
  has_paper_trail

  before_save :calc_duration
  # TODO => USE STRONG PARAMETERS
  # attr_accessible :start_time, :end_time, :status, :person_id, :description

  belongs_to :person, optional: true

  scope :verified, -> { where(:status => 'Verified')}
  STATUS_CHOICES = ['Incomplete', 'Unverified', "Error", "Verified", "Cancelled"]

  validates_presence_of :person_id
  validates_chronology :start_time, :end_time

  # validate :has_no_duplicate_timecard

  def self.working
    where(end_time: nil, status: 'Incomplete')
  end

  def concurrent_events
    return Event.none if start_time.blank? || end_time.blank?
    Event.concurrent(start_time..end_time)
  end

private
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

  def has_no_duplicate_timecard
    if find_duplicate_timecards.count > 0
      errors.add :base, "Duplicate timecard found, please edit that one instead"
    end
  end

  def calc_duration
    if start_time.blank? or end_time.blank?
      self.duration = 0
    else
      self.duration = ((end_time - start_time) / 1.hour).round(2) || 0
    end
  end
end
