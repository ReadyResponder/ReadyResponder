class Availability < ActiveRecord::Base
  has_paper_trail
  include Loggable

  belongs_to :person

  validates_presence_of :person, :status, :start_time, :end_time
  validates_chronology :start_time, :end_time

  validate :has_no_overlapping_availability

  STATUS_CHOICES = [ 'Available', 'Unavailable', "Cancelled" ]

  # Available part of event
  scope :partially_available, ->(range) { where("? > end_time AND end_time > ? OR ? > start_time AND start_time > ?", range.last, range.first, range.last, range.first) }

  scope :active, -> { where(status: ['Available', 'Unavailable']).joins(:person).where(people: {status: "Active"}) }
  scope :available, -> { where(status: "Available")}
  scope :unavailable, -> { where(status: "Unavailable")}

  scope :in_the_past, -> { where("start_time <= ?", Time.zone.now) }

  # These scopes tie the application to postgres, as they rely
  # on its range data type implementation. The ranges are left_bound closed
  # and right_bound open, as specified by the argument '[)'
  # reference: https://www.postgresql.org/docs/9.5/static/rangetypes.html
  scope :overlapping, lambda { |range|
    where("tsrange(start_time, end_time, '[)') && tsrange(TIMESTAMP?, TIMESTAMP?, '[)')",
          range.first, range.last) }

  scope :not_overlapping, lambda { |range|
    where.not("tsrange(start_time, end_time, '[)') && tsrange(TIMESTAMP?, TIMESTAMP?, '[)')",
          range.first, range.last) }

  scope :partially_overlapping, lambda { |range|
    overlapping(range).where('(start_time > :start_time AND end_time > :end_time) OR
                              (start_time < :start_time AND end_time < :end_time)',
                              start_time: range.first, end_time: range.last) }

  scope :containing, lambda { |range|
    where("tsrange(start_time, end_time, '[)') @> tsrange(TIMESTAMP?, TIMESTAMP?, '[)')",
          range.first, range.last) }

  scope :contained_in, lambda { |range|
    where("tsrange(start_time, end_time, '[)') <@ tsrange(TIMESTAMP?, TIMESTAMP?, '[)')",
          range.first, range.last) }

  scope :for_time_span, lambda { |range|
    where("end_time >= ?", range.last).
    where("start_time <= ?", range.first) }

  def to_s
    "Recorded #{status}\n start #{start_time} \n end #{end_time} \n description #{description}"
  end

  def partially_available?(event)
    return false if event.nil? || (event.end_time <= self.end_time && event.start_time >= self.start_time)
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

  def cancel!
    update(status: 'Cancelled')
  end

  private

  def has_no_overlapping_availability
    return unless person and start_time and end_time and start_time < end_time
    if Availability.where(person: person).active.overlapping(start_time..end_time).where.not(id: id).any?
      errors.add(:base, 'This availability overlaps other active availabilities for the person')
    end
  end
end
