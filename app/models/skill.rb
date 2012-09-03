class Skill < ActiveRecord::Base
  attr_accessible :required_for_cert, :required_for_pd, :required_for_sar, :status, :title, :course_ids
  has_and_belongs_to_many :courses
  has_and_belongs_to_many :titles
  
  
  
  scope :police, :conditions => {:required_for_pd => true}
  scope :cert, :conditions => {:required_for_cert => true}
  scope :sar, :conditions => {:required_for_sar => true}
  
end
