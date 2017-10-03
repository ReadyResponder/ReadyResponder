class Role < ApplicationRecord
	# TODO => USE STRONG PARAMETERS
  # attr_accessible :name
  has_and_belongs_to_many :users

  def to_s
    self.name.to_s
  end
  
end
