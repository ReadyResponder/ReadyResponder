class Title < ApplicationRecord
  has_paper_trail
  include Loggable

  # rails 5 deprecation
  # attr_accessible :comments, :description, :status, :name, :skill_ids
  has_and_belongs_to_many :people
  has_and_belongs_to_many :skills
  has_many :requirements
  validates_presence_of :name

  def to_s
    self.name
  end
end
