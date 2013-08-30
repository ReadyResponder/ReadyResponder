class Event < ActiveRecord::Base
  before_save :calc_duration

  attr_accessible :title, :description, :category, :course_id, :duration, :start_time, :end_time, :instructor, :location, :status, :timecard_ids, :person_ids, :comments
 
  def end_date_cannot_be_before_start
    if ((!end_time.blank?) and (!start_time.blank?)) and end_time < start_time
      errors.add(:end_time, "must be after the start, unless you are the Doctor")
    end
  end
  def end_date_cannot_be_before_start
    if ((!end_time.blank?) and (!start_time.blank?)) and end_time < start_time
      errors.add(:end_time, "must be after the start, unless you are the Doctor")
    end
  end
  
  validates_presence_of :category, :title, :status
  validate :end_date_cannot_be_before_start
  validates_presence_of :start_time, :if => :completed?
  validates_presence_of :end_time, :if => :completed?

  has_many :certs
  belongs_to :course
  has_many :activities, as: :loggable
  
  has_many :timecards
  has_many :people, :through => :timecards
  
  accepts_nested_attributes_for :timecards
  accepts_nested_attributes_for :certs

  CATEGORY_CHOICES = ['Training', 'Patrol', 'Meeting', 'Admin', 'Event']
  STATUS_CHOICES = ['Scheduled', 'In-session', 'Completed', 'Cancelled', "Closed"]

  def to_s
    description
  end

  def manhours
    self.timecards.sum('actual_duration')
  end
  def unknown_people 
    (Person.order('title_order').active - self.people)
  end
  def available_people
    self.timecards.available
  end
  def completed?
    status == "Completed"
  end
private
  def calc_duration #This is also used in timecards; it should be extracted out
     if !(start_time.blank?) and !(end_time.blank?)
      self.duration = ((end_time - start_time) / 1.hour).round(2) || 0
    end 
  end

end
