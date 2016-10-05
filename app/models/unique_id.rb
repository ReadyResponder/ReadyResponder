class UniqueId < ActiveRecord::Base
  belongs_to :item
  attr_accessible :category, :status, :value, :item

  CATEGORY_CHOICES = ['VIN', 'Sub-component', 'Grant', 'Slug', 'Registration',
                      'Department', 'Other']

end
