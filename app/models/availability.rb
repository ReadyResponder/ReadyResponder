class Availability < ActiveRecord::Base
  belongs_to :person
  belongs_to :event

  validates_presence_of :person, :status, :start_time, :end_time
  
  STATUS = [ 'Available', 'Unavailable', "Cancelled" ]

  scope :for_time_span, ->(range) { where("end_time >= ?", range.first).
                               where("start_time <= ?", range.last) }

  scope :available, -> { where(status: "Available")}
  scope :unavailable, -> { where(status: "Unavailable")}
end
