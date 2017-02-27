class Assignment < ActiveRecord::Base
  has_paper_trail

  belongs_to :person
  belongs_to :requirement

  STATUS = [ 'New', 'Active', 'Cancelled' ]

  scope :active, -> { where( status: "Active" ) }

  def task
    requirement.task
  end
end
