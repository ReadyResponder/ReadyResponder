class Channel < ActiveRecord::Base
  attr_accessible :carrier, :category, :content, :last_verified, :name, :person_id, :priority, :usage, :status
  
  belongs_to :person

  def self.mobile
   where("category LIKE ?", "%Mobile%")
  end
  
  def self.email
   where("category LIKE ?", "%Mail%")
  end	
  
  
  PRIORITIES = ['1-Call First','2','3','4-Call Last']
  USAGES = ['1-All','2-Emergency Only','3-Info Only','4-Testing']
  STATUSES = ['OK','Wrong Number','Bouncing']
  CATEGORIES = ['Mobile Phone', 'E-Mail','Personal E-Mail','Business E-Mail','Home Phone','Work Phone']
  CARRIERS = ['Sprint','Verizon','AT&T','Metro PCS','T-Mobile','Comcast','Other (Specify in Name)']
end
