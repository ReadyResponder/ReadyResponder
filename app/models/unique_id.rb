class UniqueId < ApplicationRecord
  has_paper_trail
  include Loggable

  belongs_to :item
  # rails 5 deprecation
  # attr_accessible :category, :status, :value, :item

  CATEGORY_CHOICES = ['VIN', 'Serial', 'Sub-component', 'Grant', 'Slug', 'Registration', 'Department', 'Other']

end
