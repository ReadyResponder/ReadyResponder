class Location < ActiveRecord::Base
  attr_accessible :category, :comments, :description, :lat, :lon, :name, :status
  
end
