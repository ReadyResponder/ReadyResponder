class Title < ActiveRecord::Base
  attr_accessible :comments, :description, :status, :title
    has_and_belongs_to_many :people
    has_and_belongs_to_many :skills

end
