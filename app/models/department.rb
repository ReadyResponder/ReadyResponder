class Department < ActiveRecord::Base
  serialize :division1, Array
  serialize :division2, Array
  attr_accessible :contact_id, :description, :manage_items, :manage_people,
    :name, :shortname, :status, :division1, :division2
  belongs_to :contact, class_name: "Person"
  has_many :people
  has_many :items
  has_many :locations


  def self.managing_items
    Department.where(manage_items: true)
  end
end
