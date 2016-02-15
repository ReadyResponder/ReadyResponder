class Department < ActiveRecord::Base
  attr_accessible :contact_id, :description, :name, :status
  belongs_to :contact, class_name: "Person"
  has_many :people
  has_many :items
  has_many :locations
end
