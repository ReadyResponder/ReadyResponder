class Assignment < ActiveRecord::Base
  has_paper_trail

  belongs_to :person
  belongs_to :requirement
  delegate :task, :to => :requirement
  delegate :event, :to => :task

  STATUS = [ 'New', 'Active', 'Cancelled' ]

  scope :active, -> { where( status: ["New", "Active"] ) }

end
