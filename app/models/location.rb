class Location < ApplicationRecord
	# TODO => USE STRONG PARAMETERS
  # attr_accessible :category, :comments, :description, :department_id,
  #                :floor, :container, :lat, :lon, :name, :status
  has_many :moves
  belongs_to :department, optional: true
  
  def to_s
    name
  end
end
