class Item < ActiveRecord::Base
  attr_accessible :category, :description, :location,
                  :model, :brand, :name, :person_id, :po_number,
                  :value, :grant, :purchase_amt, :purchase_date,
                  :sell_amt, :sell_date, :stock_number,
                  :serial1, :serial2, :serial3,
                  :source, :status, :comments, :itemimage

  mount_uploader :itemimage, ItemimageUploader 
  belongs_to :person
  has_many :repairs
  has_many :inspections

  STATUS_CHOICES = ['In Service', 'In Service - Degraded', 'Out of Service','Available','Sold', 'Destroyed']
  CATEGORY_CHOICES = ['Pump','Light','Generator','Shelter', 'Radio', 'Vehicle', 'Other']
 def recent_costs
   repairs.where("service_date > ?", 6.months.ago).pluck(:cost).compact.inject(:+)
 end
end
