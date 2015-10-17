class Skill < ActiveRecord::Base
  attr_accessible :name, :status, :course_ids, :title_ids
  has_and_belongs_to_many :courses
  has_and_belongs_to_many :titles
  validates_presence_of :name, :status

  scope :active, :conditions => {:status => "Active"}

  def to_s
    self.name
  end
end

