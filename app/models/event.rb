class Event < ActiveRecord::Base
  attr_accessible :category, :course_id, :description, :duration, :end_date, :instructor, :location, :start_date, :status
  belongs_to :course
  has_and_belongs_to_many :people
  
  #CATEGORY_CHOICES = ['Class', 'Patrol', 'Admin', 'Call-out', 'SAR']
  CATEGORY_CHOICES = ['Class']
  STATUS_CHOICES = ['Scheduled', 'In-session', 'Completed', 'Cancelled']
end
