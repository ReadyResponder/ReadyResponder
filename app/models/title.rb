class Title < ActiveRecord::Base
  attr_accessible :comments, :description, :status, :title, :skill_ids
    has_and_belongs_to_many :people
    has_and_belongs_to_many :skills

  def to_s
    self.title
  end
end
