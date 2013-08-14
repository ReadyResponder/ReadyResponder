class Item < ActiveRecord::Base
  attr_accessible :category, :description, :location_id, :model, :name, :person_id, :purchase_amt, :purchase_date, :sell_amt, :sell_date, :serial, :source, :status
  belongs_to :person
  belongs_to :location
  has_many :repairs

  STATUS_CHOICES = ['In Service','Out of Service','Available','Sold', 'Destroyed']
  CATEGORY_CHOICES = ['Pump','Light','Generator','Shelter', 'Other']

end
