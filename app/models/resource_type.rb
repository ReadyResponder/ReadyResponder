class ResourceType < ApplicationRecord
  has_many :items

  validates_presence_of :status
  validates_presence_of :name
  validates_uniqueness_of :name
  validates_uniqueness_of :fema_code
end
