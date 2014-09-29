class Phone < Channel
  attr_accessible :carrier, :priority, :sms_available

  belongs_to :person

  PRIORITIES = ['1-Call First','2','3','4-Call Last']
  CARRIERS = ['Sprint','Verizon','AT&T','Metro PCS','T-Mobile','Comcast','Cricket', 'Other']
end
