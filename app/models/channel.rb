class Channel < ActiveRecord::Base
# this is the parent class of phones,emails,etc....

 set_inheritance_column :channel_type	
  attr_accessible :category, :content, :last_verified, :name, :person_id, :usage, :status

  belongs_to :person

  USAGES = ['1-All','2-Emergency Only','3-Info Only','4-Testing']
  STATUSES = ['OK','Invalid']
  CATEGORIES = ['Home','Business']
  CHANNEL_TYPES = ["Email", "Cell", "Landline", "Phone", "Twitter"]

  def phone?
    ["Phone", 'Cell', 'Landline'].include?(self.channel_type)
  end
end
