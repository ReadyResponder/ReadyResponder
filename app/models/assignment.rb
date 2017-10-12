class Assignment < ApplicationRecord
  has_paper_trail

  belongs_to :person, optional: true
  belongs_to :requirement, optional: true
  delegate :task, :to => :requirement
  delegate :event, :to => :task
  validates_presence_of :person

  STATUS_CHOICES = [ 'New', 'Active', 'Cancelled' ]

  scope :active, -> { where( status: ["New", "Active"] ) }

  scope :for_time_span, ->(range) {
                      where("end_time >= ?", range.last).
                      where("start_time <= ?", range.first)
                    }

  def description
    task.to_s
  end
end
