class Department < ActiveRecord::Base
  serialize :division1, Array
  serialize :division2, Array
  attr_accessible :contact_id, :description, :name, :status, :division1, :division2
  belongs_to :contact, class_name: "Person"
  has_many :people
  has_many :items
  has_many :locations
end
