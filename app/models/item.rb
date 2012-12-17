class Item < ActiveRecord::Base
  attr_accessible :category, :description, :location_id, :model, :name, :person_id, :purchase_amt, :purchase_date, :sell_amt, :sell_date, :serial, :source, :status
  belongs_to :person
  STATUS_CHOICES = ['In Service','Out of Service','Available','Sold', 'Destroyed']
  
 # belongs_to :person, :as => :owner
end
