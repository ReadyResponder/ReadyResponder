class Repair < ActiveRecord::Base
  has_paper_trail

  attr_accessible :category, :comments, :description,
                  :item_id, :person_id, :service_date,
                  :status, :user_id, :cost, :condition
  belongs_to :item
  belongs_to :person
  delegate :item_category, :to => :item
  delegate :item_type, :to => :item

  validates_numericality_of :cost, :allow_nil => true, :allow_blank => true
  validates_presence_of :status
  STATUS_CHOICES = ['Needed', 'In-progress', 'Awaiting Parts',
                    'Completed - Repaired', 'Completed - No Trouble Found']
  CATEGORY_CHOICES = ['Repair', 'Inspection' ]
  CONDITION_CHOICES = ['Ready', 'In-Service - Maintenance', 
                       'In-Service - Degraded', 'Out of Service' ]

  def repairer_name
    return person.present? ? person.name : "Unknown"
  end

  scope :not_completed, (-> { where('status NOT LIKE ?', '%Completed%') })
  scope :not_ready, (-> { where('condition NOT LIKE ?', '%Ready%') })
end
