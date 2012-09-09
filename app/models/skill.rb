class Skill < ActiveRecord::Base
  attr_accessible :title, :status, :course_ids, :title_ids
  has_and_belongs_to_many :courses
  has_and_belongs_to_many :titles
  validates_presence_of :title, :status

  scope :active, :conditions => {:status => "Active"}
  
  def to_s
    self.title
  end

end
