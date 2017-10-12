class ResourceType < ApplicationRecord
  # TODO => USE STRONG PARAMETERS
  # attr_accessible :description, :fema_code, :fema_kind, :name, :status
  has_many :items

  validates_presence_of :status
  validates_presence_of :name
  validates_uniqueness_of :name
  validates_uniqueness_of :fema_code
end
