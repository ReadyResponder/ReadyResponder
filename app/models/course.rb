class Course < ActiveRecord::Base
  attr_accessible :category, :comments, :description, :duration, :required_for_pd, :required_for_cert, :required_for_sar, :status, :term, :title
  has_many :certs
  
  CATEGORY_CHOICES = ['General', 'Police', 'Admin', 'CERT', 'SAR']
  REQUIRED_FOR_CHOICES = ['Police', 'CERT','SAR']

  validates_presence_of :title, :status
  scope :active,  :conditions => {:status => "Active"}
end
