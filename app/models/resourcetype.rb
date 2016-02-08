class Resourcetype < ActiveRecord::Base
  attr_accessible :description, :femacode, :femakind, :name, :status
  has_many :items
  
  validates_presence_of :status
  validates_presence_of :name

end
