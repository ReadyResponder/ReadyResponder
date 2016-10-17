class Phone < Channel
  include ActiveModel::ForbiddenAttributesProtection
  belongs_to :person

  PRIORITIES = [
    ['Use First', 1], ['Use Second', 2], ['Use Third', 3], ['Use Last', 4]
  ]
  CARRIERS = [
    'Sprint','Verizon','AT&T','Metro PCS','T-Mobile',
    'Comcast','Cricket', 'Other'
  ]
  TYPES = ["Cell", "Landline", "Phone"]
end
