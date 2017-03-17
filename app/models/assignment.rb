class Assignment < ActiveRecord::Base
  has_paper_trail

  belongs_to :person
  belongs_to :requirement
  delegate :task, :to => :requirement
  delegate :event, :to => :task

  STATUS_CHOICES = [ 'New', 'Active', 'Cancelled' ]

  scope :active, -> { where( status: ["New", "Active"] ) }

  def description
    task.to_s
  end
end
