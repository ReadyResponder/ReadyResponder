class Item < ActiveRecord::Base
  has_paper_trail

  attr_accessible :category, :description, :location_id,
                  :model, :brand, :name, :owner_id, :po_number,
                  :value, :grant, :purchase_amt, :purchase_date,
                  :sell_amt, :sell_date, :stock_number,
                  :source, :status, :comments, :item_image,
                  :department_id, :resource_type_id, :item_type_id,
                  :unique_ids_attributes

  # validates_chronology :purchase_date, :sell_date     # ? - if so, needs a test
  # validates_chronology :grantstart, :grantexpiration  # ? - if so, needs a test

  mount_uploader :item_image, ItemImageUploader

  validates_numericality_of :value, :allow_nil => true, :allow_blank => true
  validates_numericality_of :sell_amt, :allow_nil => true, :allow_blank => true
  validates_numericality_of :purchase_amt, :allow_nil => true, :allow_blank => true

  belongs_to :owner, class_name: 'Person', inverse_of: :items
  belongs_to :resource_type
  belongs_to :location
  belongs_to :department
  belongs_to :item_type
  has_many :repairs
  has_many :inspections
  has_many :unique_ids
  accepts_nested_attributes_for :unique_ids,
           allow_destroy: true,
           reject_if: :all_blank

  STATUS_CHOICES = ['In Service', 'In Service - Degraded', 'Out of Service','Available','Sold', 'Destroyed']
  CATEGORY_CHOICES = ['Pump','Light','Generator','Shelter', 'Radio', 'Vehicle', 'Other']

  def recent_costs
    repairs.where("service_date > ?", 6.months.ago).pluck(:cost).compact.inject(:+) || 0
  end

  def location_name
    location.name if location
    "Unknown"
  end
  
end
