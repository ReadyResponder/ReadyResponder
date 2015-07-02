class Item < ActiveRecord::Base
  attr_accessible :category, :description, :location_id, :model, :name, :person_id, :po_number, :value, :purchase_amt, :purchase_date, :sell_amt, :sell_date, :serial1, :serial2, :serial3, :source, :status
  belongs_to :person
  belongs_to :location
  has_many :repairs

  STATUS_CHOICES = ['In Service', 'In Service - Degraded', 'Out of Service','Available','Sold', 'Destroyed']
  CATEGORY_CHOICES = ['Pump','Light','Generator','Shelter', 'Radio', 'Vehicle', 'Other']
end

