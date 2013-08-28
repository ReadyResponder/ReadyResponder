class Event < ActiveRecord::Base
  before_save :calc_duration

  attr_accessible :title, :description, :category, :course_id, :duration, :start_time, :end_time, :instructor, :location, :status, :timeslot_ids, :person_ids, :comments
 
  def end_date_cannot_be_before_start
    if ((!end_time.blank?) and (!start_time.blank?)) and end_time < start_time
      errors.add(:end_time, "must be after the start, unless you are the Doctor")
    end
  end
  
  validates_presence_of :category, :title, :status
  validate :end_date_cannot_be_before_start
  
  has_many :certs
  belongs_to :course
  
  has_many :timeslots
  has_many :people, :through => :timeslots
  
  accepts_nested_attributes_for :timeslots
  accepts_nested_attributes_for :certs

  #CATEGORY_CHOICES = ['Class', 'Patrol', 'Admin', 'Call-out', 'SAR']
  CATEGORY_CHOICES = ['Training', 'Patrol', 'Meeting', 'Admin', 'Event']
  STATUS_CHOICES = ['Scheduled', 'In-session', 'Completed', 'Cancelled']

  def to_s
    description
  end

  def manhours
    self.timeslots.sum('actual_duration')
  end
  def unknown_people 
    (Person.order('title_order').active - self.people)
  end
  def available_people
    self.timeslots.available
  end
private
  def calc_duration #This is also used in timeslots; it should be extracted out
     if !(start_time.blank?) and !(end_time.blank?)
      self.duration = ((end_time - start_time) / 1.hour).round(2) || 0
    end 
  end
end
