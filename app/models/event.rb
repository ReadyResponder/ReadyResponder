class Event < ActiveRecord::Base
  before_save :calc_duration
  validate :end_date_cannot_be_before_start
 
  def end_date_cannot_be_before_start
    if ((!end_date.blank?) and (!start_date.blank?)) and end_date < start_date
      errors.add(:end_date, "must be after the start, unless you are the Doctor")
    end
  end
  validates_presence_of :description
  
  attr_accessible :category, :course_id, :description, :duration, :end_date, :instructor, :location, :start_date, :status
  belongs_to :course
  has_many :attendances
  has_many :people, :through => :attendances
  
  #CATEGORY_CHOICES = ['Class', 'Patrol', 'Admin', 'Call-out', 'SAR']
  CATEGORY_CHOICES = ['Training', 'Patrol', 'Meeting']
  STATUS_CHOICES = ['Scheduled', 'In-session', 'Completed', 'Cancelled']
  
  def calc_duration
    unless start_date.blank? || end_date.blank?
      self.duration = (end_date - start_date) / 3600 || 0
    end 
  end

end
