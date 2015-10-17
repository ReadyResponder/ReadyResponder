class Channel < ActiveRecord::Base

  attr_accessible :category, :content, :name, :status, :usage
  attr_accessible :carrier, :sms_available, :priority, :type, :_destroy, :person_id

  validates_presence_of :type, :content, :status, :usage, :priority

  belongs_to :person, :inverse_of => :channels

  PRIORITIES = ['1-Call First','2','3','4-Call Last']
  CARRIERS = ['Sprint','Verizon','AT&T','Metro PCS','T-Mobile','Comcast','Cricket', 'Other']
  USAGES = ['1-All','2-Emergency Only','3-Info Only','4-Testing']
  STATUSES = ['OK','Invalid']
  CATEGORIES = ['Home','Business']
  CHANNEL_TYPES = ["Phone", "Email", "Cell", "Landline", "Twitter"]

  def phone?
    ["Phone", 'Cell', 'Landline'].include?(self.type)
  end
end

