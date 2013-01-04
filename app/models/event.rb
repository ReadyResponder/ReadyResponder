class Event < ActiveRecord::Base
  before_save :calc_duration

  attr_accessible :category, :course_id, :description, :duration, :end_date, :instructor, :location, :start_date, :status
  belongs_to :course
  has_and_belongs_to_many :people
  
  #CATEGORY_CHOICES = ['Class', 'Patrol', 'Admin', 'Call-out', 'SAR']
  CATEGORY_CHOICES = ['Training', 'Patrol', 'Meeting']
  STATUS_CHOICES = ['Scheduled', 'In-session', 'Completed', 'Cancelled']
  
  def calc_duration
    unless start_date.blank? || end_date.blank?
      self.duration = (end_date - start_date) / 3600 || 0
    end 
  end

end
