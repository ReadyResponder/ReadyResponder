class Event < ActiveRecord::Base
  has_paper_trail
  before_save :calc_duration, :trim_id_code

  validates_presence_of :category, :title, :status, :id_code
  validates_uniqueness_of :id_code, :title

  validates_presence_of :start_time, :end_time
  validates_chronology :start_time, :end_time

  belongs_to :template, :class_name => "Event"
  has_many :templated_events, class_name: "Event", foreign_key: "template_id"
  has_and_belongs_to_many :departments
  has_many :certs
  belongs_to :course
  has_many :activities, as: :loggable

  has_many :tasks, -> { where("tasks.status = 'Active'" ) }
  has_many :requirements, :through => :tasks
  has_many :assignments, :through => :requirements
  has_many :people, through: :assignments

  has_many :notifications

  accepts_nested_attributes_for :certs

  scope :upcoming, -> {
    order("start_time ASC").where( "status in (?) AND end_time > ?",
    ["Scheduled", "In-session"], Time.now )
  }

  scope :actual, -> { where(:is_template => false)}
  scope :templates, -> { where(:is_template => true, :status => "In-session")}

  def self.concurrent (range)
    where_clause =  '(:end >= start_time AND start_time >= :start) OR '
    where_clause += '(:end >= end_time AND end_time >= :start) OR '
    where_clause += '(start_time <= :start AND end_time >= :end)'
    order("start_time ASC").where(where_clause,
         { start: range.first, end: range.last })
   end

  CATEGORY_CHOICES = ['Training', 'Patrol', 'Meeting', 'Admin', 'Event']
  STATUS_CHOICES = ['Scheduled', 'In-session', 'Completed', 'Cancelled', "Closed"]

  def to_s
    title
  end

  def unavailabilities
    responses.unavailable + partial_responses.unavailable
  end

  def unavailable_people
    unavailabilities.map{|a| a.person}
  end

  def partial_responses
    Availability.partially_available(self.start_time..self.end_time).active
  end

  def partial_availabilities
    partial_responses.available
  end

  def partially_available_people
    partial_availabilities.includes(:person).map{|a| a.person}.uniq
  end

  def partial_responding_people
    self.partial_responses.map { |a| a.person }
  end

  def availabilities
    responses.available
  end

  def available_people
    responses.includes(:person).available.map{|a|a.person}.uniq
  end

  def responses
    Availability.for_time_span(self.start_time..self.end_time).active
  end

  def responding_people
    self.responses.map { |a| a.person }
  end

  def eligible_people
    Person.active.where(department: self.departments)
  end

  def unresponsive_people
    eligible_people - responding_people - partial_responding_people
  end

  def manhours
    self.timecards.sum('actual_duration')
  end

  def self.find_by_code(id_code)
    return ::Error::Base.new({code: 211, description: "No id_code given"}) if id_code.blank?
    event = Event.where(id_code: id_code).first
    return ::Error::Base.new({code: 201, description: "Event #{id_code} not found"}) if event.blank?
    return event
  end

  def assignees
    folks = assignments.active.map {|a| a.person }
    folks.uniq if folks.present?
    return folks
  end

  def completed?
    status == "Completed"
  end

  def use_a_template
    logger.info ">>> Using Event template #{self.template.title}"
    self.template.tasks.each do |template_task|
      logger.info ">>>> Duplicating #{template_task.title}"
      new_task = template_task.dup
      new_task.start_time = start_time
      new_task.end_time = end_time
      new_task.save
      self.tasks << new_task
      template_task.requirements.each do |req|
        logger.info ">>>>> Duplicating #{template_task.title} requirement #{req}"
        new_task.requirements << req.dup
      end
    end
  end

private
  def calc_duration #This is also used in timecards; it should be extracted out
     if !(start_time.blank?) and !(end_time.blank?)
      self.duration = ((end_time - start_time) / 1.hour).round(2) || 0
     end
  end

  def trim_id_code
    self.id_code = self.id_code.split[0].downcase
  end
end
