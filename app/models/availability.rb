class Availability < ActiveRecord::Base
  belongs_to :person

  validates_presence_of :person, :status, :start_time, :end_time
  validates_chronology :start_time, :end_time

  STATUS = [ 'Available', 'Unavailable', "Cancelled" ]

  # Available the entire event
  scope :for_time_span, ->(range) { where("end_time >= ?", range.last).
                               where("start_time <= ?", range.first) }

  # Available part of event
  scope :partially_available, ->(range) { where("? >= end_time AND end_time >= ? OR ? >= start_time AND start_time >= ?", range.last, range.first, range.last, range.first) }


  scope :available, -> { where(status: "Available")}
  scope :unavailable, -> { where(status: "Unavailable")}

  def partially_available?(event)
    return false if event.nil? || (event.end_time == self.end_time && event.start_time == self.start_time)
    (event.end_time >= self.end_time && self.end_time >= event.start_time) || (event.end_time >= self.start_time && self.start_time >= event.start_time)
  end
end
