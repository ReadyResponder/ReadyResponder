class Item < ApplicationRecord
  has_paper_trail

  # validates_chronology :purchase_date, :sell_date     # ? - if so, needs a test
  # validates_chronology :grantstart, :grantexpiration  # ? - if so, needs a test

  mount_uploader :item_image, ItemImageUploader

  validates_numericality_of :qty, :greater_than_or_equal_to => 0
  validates_numericality_of :value, :allow_nil => true, :allow_blank => true
  validates_numericality_of :sell_amt, :allow_nil => true, :allow_blank => true
  validates_numericality_of :purchase_amt, :allow_nil => true, :allow_blank => true

  belongs_to :owner, class_name: 'Person', inverse_of: :items, optional: true
  belongs_to :resource_type, optional: true
  belongs_to :location, optional: true
  belongs_to :department, optional: true
  belongs_to :item_type, optional: true
  has_many :repairs
  has_many :inspections
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
