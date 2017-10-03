class Repair < ApplicationRecord
  # TODO => USE STRONG PARAMETERS
  # attr_accessible :category, :comments, :description,
  #                 :item_id, :person_id, :service_date,
  #                 :status, :user_id, :cost
  belongs_to :item, optional: true
  belongs_to :person, optional: true
  delegate :item_category, :to => :item
  delegate :item_type, :to => :item


  validates_numericality_of :cost, :allow_nil => true, :allow_blank => true
  validates_presence_of :status
  STATUS_CHOICES = ['Needed', 'In-progress', 'Awaiting Parts',
                    'Completed - Repaired', 'Completed - No Trouble Found']
  CATEGORY_CHOICES = ['Repair', 'Inspection' ]

  def repairer_name
    return person.present? ? person.name : "Unknown"
  end
end
