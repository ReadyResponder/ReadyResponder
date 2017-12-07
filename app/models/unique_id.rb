class UniqueId < ActiveRecord::Base
  has_paper_trail
  include Loggable

  belongs_to :item
  attr_accessible :category, :status, :value, :item

  CATEGORY_CHOICES = ['VIN', 'Serial', 'Sub-component', 'Grant', 'Slug', 'Registration', 'Department', 'Other']

end
