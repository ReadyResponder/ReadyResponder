class Vendor < ActiveRecord::Base
  has_many :items

  validates :name, presence: true

  attr_accessible :name, :street, :city, :state, :zipcode,
  :status, :comments

end
