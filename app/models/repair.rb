class Repair < ActiveRecord::Base
  attr_accessible :category, :comments, :description,
                  :item_id, :person_id, :service_date,
                  :status, :user_id, :cost
  belongs_to :item
  belongs_to :person
  validates_numericality_of :cost, :allow_nil => true, :allow_blank => true

  STATUS_CHOICES = ['Needed', 'In-progress', 'Awaiting Parts',
                    'Completed - Repaired', 'Completed - No Trouble Found']
  CATEGORY_CHOICES = ['Repair', 'Inspection' ]

  def repairer_name
    return person.present? ? person.name : "Unknown"
  end
end
