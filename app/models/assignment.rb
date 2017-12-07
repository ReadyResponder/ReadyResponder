class Assignment < ActiveRecord::Base
  has_paper_trail
  include Loggable

  belongs_to :person
  belongs_to :requirement

  delegate :task, to: :requirement
  delegate :event, to: :task

  validates_presence_of :person

  STATUS_CHOICES = [ 'New', 'Active', 'Cancelled' ]

  scope :active, -> { where( status: ["New", "Active"] ) }

  # This scope ties the application to postgres, as it relies
  # on its range data type implementation. The ranges are left_bound closed
  # and right_bound open, as specified by the argument '[)'
  # reference: https://www.postgresql.org/docs/9.5/static/rangetypes.html
  scope :for_time_span, lambda { |range|
    where("tsrange(start_time, end_time, '[)') @> tsrange(TIMESTAMP?, TIMESTAMP?, '[)')",
          range.first, range.last) }

  def description
    task.to_s
  end
end
