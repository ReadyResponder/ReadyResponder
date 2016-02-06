class Location < ActiveRecord::Base
  attr_accessible :category, :comments, :description, :lat, :lon, :name, :status
  has_many :moves
  has_many :items
end
