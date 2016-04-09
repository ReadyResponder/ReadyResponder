class Item < ActiveRecord::Base
  attr_accessible :category, :description, :location_id,
                  :model, :brand, :name, :owner_id, :po_number,
                  :value, :grant, :purchase_amt, :purchase_date,
                  :sell_amt, :sell_date, :stock_number,
                  :serial1, :serial2, :serial3,
                  :source, :status, :comments, :item_image,
                  :department_id, :resource_type_id, :item_type_id,
                  :unique_ids_attributes

  mount_uploader :item_image, ItemImageUploader
  validates_numericality_of :value
  belongs_to :owner, class_name: 'Person', inverse_of: :items
  belongs_to :resource_type
  belongs_to :location
  belongs_to :department
  belongs_to :item_type
  has_many :repairs
  has_many :inspections
  has_many :unique_ids
  accepts_nested_attributes_for :unique_ids

  STATUS_CHOICES = ['In Service', 'In Service - Degraded', 'Out of Service','Available','Sold', 'Destroyed']
  CATEGORY_CHOICES = ['Pump','Light','Generator','Shelter', 'Radio', 'Vehicle', 'Other']

  def recent_costs
    repairs.where("service_date > ?", 6.months.ago).pluck(:cost).compact.inject(:+)
  end

end
