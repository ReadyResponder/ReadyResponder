class Skill < ApplicationRecord
  has_and_belongs_to_many :courses
  has_and_belongs_to_many :titles
  has_many :requirements
  validates_presence_of :name, :status

  scope :active, -> { where( status: "Active" ) }

  def to_s
    self.name
  end

end
