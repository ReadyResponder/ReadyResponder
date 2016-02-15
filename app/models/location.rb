class Location < ActiveRecord::Base
  attr_accessible :category, :comments, :description, :floor, :container, :lat, :lon, :name, :status
  has_many :moves
  belongs_to :department
end
