class Title < ActiveRecord::Base
  attr_accessible :comments, :description, :status, :name, :skill_ids
    has_and_belongs_to_many :people
    has_and_belongs_to_many :skills

  def to_s
    self.name
  end
end
