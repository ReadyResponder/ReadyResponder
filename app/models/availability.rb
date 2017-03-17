class Availability < ActiveRecord::Base
  belongs_to :person

  before_create :cancel_duplicates

  validates_presence_of :person, :status, :start_time, :end_time
  validates_chronology :start_time, :end_time

  STATUS = [ 'Available', 'Unavailable', "Cancelled" ]

  # Available the entire event
  scope :for_time_span, ->(range) { where("end_time >= ?", range.last).
                               where("start_time <= ?", range.first) }

  # Available part of event
  scope :partially_available, ->(range) { where("? > end_time AND end_time > ? OR ? > start_time AND start_time > ?", range.last, range.first, range.last, range.first) }


  scope :available, -> { where(status: "Available")}
  scope :unavailable, -> { where(status: "Unavailable")}

  scope :active, -> { joins(:person).where(people: {status: "Active"}) }

  def to_s
    "Recorded #{status}\n start #{start_time} \n end #{end_time} \n description #{description}"
  end

  def partially_available?(event)
    return false if event.nil? || (event.end_time == self.end_time && event.start_time == self.start_time)
    (event.end_time >= self.end_time && self.end_time >= event.start_time) || (event.end_time >= self.start_time && self.start_time >= event.start_time)
  end

  def self.process_data
    availabilities = Availability.available
    start_time = availabilities.map(&:start_time).min.to_datetime
    end_time = availabilities.map(&:end_time).max.to_datetime
    data = []
    data <<
      (start_time..end_time).map do |date|
        count = Availability.where('date(start_time) <= ? AND date(end_time) >= ?', date, date).count
        { 'Date' => date, 'Count' => count }
      end
  end

  private

  def cancel_duplicates
    previous_availabilities = person.availabilities.for_time_span(start_time..end_time).order(:created_at)
    previous_availabilities.each do |a|
      if start_time == a.start_time && end_time == a.end_time
        a.update(status: "Cancelled") unless self == a
      end
    end
  end
end
