class Availability < ActiveRecord::Base
  belongs_to :person

  validates_presence_of :person, :status, :start_time, :end_time
  validates_chronology :start_time, :end_time
  # Can not claim same timings again
  validates_uniqueness_of :start_time, :end_time, scope: :person_id
  validate :must_not_enclose_previously_claimed_times

  STATUS = [ 'Available', 'Unavailable', 'Cancelled' ]

  # Available the entire event
  scope :for_time_span, -> (range) { where("end_time >= ?", range.last).
                               where("start_time <= ?", range.first) }

  # Available part of event
  scope :partially_available, -> (range) { where("? >= end_time AND end_time >= ? OR ? >= start_time AND start_time >= ?", range.last, range.first, range.last, range.first) }

  scope :available, -> { where(status: "Available") }
  scope :unavailable, -> { where(status: "Unavailable") }
  scope :cancelled, -> { where(status: "Cancelled") }

  def partially_available?(event)
    return false if event.nil? || (event.end_time == self.end_time && event.start_time == self.start_time)
    (event.end_time >= self.end_time && self.end_time >= event.start_time) || (event.end_time >= self.start_time && self.start_time >= event.start_time)
  end

  private
  # Does not allow people to fill in times enclosing other times already claimed
  # For Example,
  # If Person A is available from 9:00 AM to 10:00 AM,
  # He/She may not fill in another time from 9:15 to 10:15 AM
  # However he/she may fill in from 10:00 AM to 10:15 AM
  def must_not_enclose_previously_claimed_times
    if person.availabilities.where.not.cancelled.where("? > end_time AND end_time > ? OR ? > start_time AND start_time > ?", end_time, start_time, end_time, start_time).present?
      errors.add(:unpermitted, "Start Time and End Time can not enclose previously claimed times")
    end
  end
end
