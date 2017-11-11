class Title < ActiveRecord::Base
  has_paper_trail

  attr_accessible :comments, :description, :status, :order, :name, :skill_ids
  has_and_belongs_to_many :people
  has_and_belongs_to_many :skills
  has_many :requirements
  has_many :departments
  validates_presence_of :name

  def to_s
    self.name
  end
  
end
