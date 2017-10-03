class Inspection < ApplicationRecord

  belongs_to :item, optional: true
  has_many :inspection_questions
  validates :inspection_date, presence: true
  validates :item, presence: true
  STATUS_CHOICES = ['Complete - Passed', 'Complete - Failed', 'Incomplete']

end
