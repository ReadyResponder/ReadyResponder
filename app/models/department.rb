class Department < ApplicationRecord
  serialize :division1, Array
  serialize :division2, Array

  belongs_to :contact, class_name: "Person", optional: true
  has_many :people
  has_many :items
  has_many :locations
  has_many :item_categories
  has_and_belongs_to_many :events
  has_and_belongs_to_many :notifications

  validates_presence_of :shortname

  scope :active, -> { where( status: "Active" ) }

  def self.managing_people
    Department.where(manage_people: true)
  end

  def self.managing_items
    Department.where(manage_items: true)
  end

  def formatted_division1
    division1.join(', ')
  end

  def formatted_division2
    division2.join(', ')
  end
end
