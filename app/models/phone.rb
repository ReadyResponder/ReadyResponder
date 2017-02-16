class Phone < Channel
  include ActiveModel::ForbiddenAttributesProtection
  belongs_to :person
  validates_format_of :content, :with => /\A[+][1]\d{10}\z/,
                                :allow_nil => true, :allow_blank => true
  validates_uniqueness_of :content, :allow_nil => true, :allow_blank => true

  PRIORITIES = [
    ['Use First', 1], ['Use Second', 2], ['Use Third', 3], ['Use Last', 4]
  ]
  CARRIERS = [
    'Sprint','Verizon','AT&T','Metro PCS','T-Mobile',
    'Comcast','Cricket', 'Other'
  ]
  TYPES = ["Cell", "Landline", "Phone"]
end
