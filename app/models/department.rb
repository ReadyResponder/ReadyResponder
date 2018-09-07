class Department < ApplicationRecord
  has_paper_trail
  include Loggable

  serialize :division1, Array
  serialize :division2, Array
  # rails 5 deprecation
  # attr_accessible :contact_id, :description, :manage_items, :manage_people,
    # :name, :shortname, :status, :division1, :division2
  belongs_to :contact, class_name: "Person"
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
