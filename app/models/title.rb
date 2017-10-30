class Title < ApplicationRecord
  has_and_belongs_to_many :people
  has_and_belongs_to_many :skills
  has_many :requirements
  validates_presence_of :name

  def to_s
    self.name
  end
end
