class Location < ActiveRecord::Base
  attr_accessible :category, :comments, :description, :department_id,
                  :floor, :container, :lat, :lon, :name, :status
  has_many :moves
  belongs_to :department
  def to_s
    name
  end
end
