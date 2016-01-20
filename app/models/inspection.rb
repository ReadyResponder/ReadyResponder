class Inspection < ActiveRecord::Base

  # attr_accessible :title, :body
  belongs_to :item
  has_many :inspectionquestions

  STATUS_CHOICES = ['Complete - Passed', 'Complete - Failed', 'Incomplete']

end
