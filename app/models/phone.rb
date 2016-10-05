class Phone < Channel
  include ActiveModel::ForbiddenAttributesProtection
  belongs_to :person

  PRIORITIES = [1, 2, 3, 4]
  CARRIERS = ['Sprint','Verizon','AT&T','Metro PCS','T-Mobile','Comcast','Cricket', 'Other']
  TYPES = ["Cell", "Landline", "Phone"]
end
