class Repair < ActiveRecord::Base
  attr_accessible :category, :comments, :description, :item_id, :person_id, :service_date, :status, :user_id
end
