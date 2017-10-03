class UniqueId < ApplicationRecord
  belongs_to :item, optional: true
  # TODO => USE STRONG PARAMETERS
  # attr_accessible :category, :status, :value, :item

  CATEGORY_CHOICES = ['VIN', 'Sub-component', 'Grant', 'Slug', 'Registration',
                      'Department', 'Other']

end
