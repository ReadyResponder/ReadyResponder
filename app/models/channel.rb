class Channel < ActiveRecord::Base
  attr_accessible :carrier, :category, :content, :last_verified, :name, :person_id, :priority, :usage, :status
  
  belongs_to :person
  
  PRIORITIES = ['1-All','2-Emergency Only','3-Info Only','4-Testing']
  CATEGORIES = ['Mobile', 'Personal Mobile', 'Business Mobile','E-Mail','Personal E-Mail','Business E-Mail','Home Phone','Work Phone']
  CARRIERS = ['Sprint','Verizon','AT&T','Metro PCS','T-Mobile','Comcast','Other (Specify in Name)']
end
