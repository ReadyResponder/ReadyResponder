class Channel < ActiveRecord::Base
  attr_accessible :carrier, :category, :content, :last_verified, :name, :person_id, :priority, :usage, :status
  
  belongs_to :person
end
