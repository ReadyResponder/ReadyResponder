class Channel < ActiveRecord::Base
  attr_accessible :category, :content, :last_verified, :name, :person_id, :usage, :status
  
  belongs_to :person

  USAGES = ['1-All','2-Emergency Only','3-Info Only','4-Testing']
  STATUSES = ['OK','Invalid']
  CATEGORIES = ['Home','Business']

end
