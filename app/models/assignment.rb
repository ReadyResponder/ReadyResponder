class Assignment < ActiveRecord::Base
  has_paper_trail

  belongs_to :person
  belongs_to :requirement

  def task
    requirement.task
  end
end
