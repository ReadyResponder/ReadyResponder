class Repair < ActiveRecord::Base
  attr_accessible :category, :comments, :description, :item_id, :person_id, :service_date, :status, :user_id
  belongs_to :item
  belongs_to :person

  STATUS_CHOICES = ['Needed', 'In-progress', 'Awaiting Parts', 'Completed - Repaired', 'Completed - No Trouble Found']
  CATEGORY_CHOICES = ['Repair', 'Inspection' ]
end

