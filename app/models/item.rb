class Item < ActiveRecord::Base
  has_paper_trail

  attr_accessible :category, :description, :location_id, :qty,
                  :model, :brand, :name, :owner_id, :po_number,
                  :value, :grant, :purchase_amt, :purchase_date,
                  :sell_amt, :sell_date, :stock_number,
                  :source, :status, :condition, :comments, :item_image,
                  :department_id, :resource_type_id, :item_type_id,
                  :unique_ids_attributes, :grant_id

  # validates_chronology :purchase_date, :sell_date     # ? - if so, needs a test
  # validates_chronology :grantstart, :grantexpiration  # ? - if so, needs a test

  mount_uploader :item_image, ItemImageUploader

  validates_numericality_of :qty, :greater_than_or_equal_to => 0
  validates_numericality_of :value, :allow_nil => true, :allow_blank => true
  validates_numericality_of :sell_amt, :allow_nil => true, :allow_blank => true
  validates_numericality_of :purchase_amt, :allow_nil => true, :allow_blank => true

  belongs_to :owner, class_name: 'Person', inverse_of: :items
  belongs_to :resource_type
  belongs_to :location
  belongs_to :department
  belongs_to :item_type
  belongs_to :grantor, foreign_key: :grant_id, class_name: 'Grant'
  has_many :repairs
  has_many :inspections
  has_many :inspection_questions, through: :inspections
  has_many :unique_ids

  delegate :item_category, :to => :item_type

  accepts_nested_attributes_for :unique_ids,
           allow_destroy: true,
           reject_if: :all_blank

  STATUS_CHOICES = ['Assigned', 'Unassigned', 'Retired']
  CONDITION_CHOICES = ['Ready', 'In-Service - Maintenance', 'In-Service - Degraded', 'Out of Service' ]

  def to_s
    name
  end

  def recent_costs
    repairs.where("service_date > ?", 6.months.ago).pluck(:cost).compact.inject(:+) || 0
  end

  def location_name
    return location.name if location
    "Unknown"
  end

end
