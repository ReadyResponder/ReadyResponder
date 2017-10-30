class UniqueId < ApplicationRecord
  belongs_to :item, optional: true

  CATEGORY_CHOICES = ['VIN', 'Sub-component', 'Grant', 'Slug', 'Registration',
                      'Department', 'Other']

end
