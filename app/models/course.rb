class Course < ApplicationRecord
  has_paper_trail
  
  has_many :certs
  has_many :people, :through => :certs
  has_many :events, :through => :certs
  has_and_belongs_to_many :skills

  CATEGORY_CHOICES = ['General', 'Police', 'Admin', 'CERT', 'SAR']

  validates_presence_of :name, :status
  scope :active, -> { where( status: "Active" ) }
end
