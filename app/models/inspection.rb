class Inspection < ActiveRecord::Base

  belongs_to :item

  STATUS_CHOICES = ['Complete - Passed', 'Complete - Failed', 'Incomplete']

end
