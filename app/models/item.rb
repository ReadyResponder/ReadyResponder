class Item < ActiveRecord::Base
  attr_accessible :category, :description, :location_id,
                  :model, :brand, :name, :owner_id, :po_number,
                  :value, :grant, :purchase_amt, :purchase_date,
                  :sell_amt, :sell_date, :stock_number,
                  :serial1, :serial2, :serial3,
                  :source, :status, :comments, :item_image

  mount_uploader :item_image, ItemImageUploader
  belongs_to :owner, class_name: 'Person', inverse_of: :items
  belongs_to :resource_type
  belongs_to :location
  belongs_to :department
  has_many :repairs
  has_many :inspections

  STATUS_CHOICES = ['In Service', 'In Service - Degraded', 'Out of Service','Available','Sold', 'Destroyed']
  CATEGORY_CHOICES = ['Pump','Light','Generator','Shelter', 'Radio', 'Vehicle', 'Other']

  def recent_costs
    repairs.where("service_date > ?", 6.months.ago).pluck(:cost).compact.inject(:+)
  end

end
