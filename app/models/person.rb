class Person < ApplicationRecord
  has_paper_trail
  acts_as_taggable # Alias for acts_as_taggable_on :tags
  
  include Commentable
  include Loggable

  include ActiveModel::ForbiddenAttributesProtection
  mount_uploader :portrait, PortraitUploader

  before_validation :calculate_title_order

  has_many :certs, -> { where("certs.status = 'Active'") }
  has_many :recipients
  has_many :notifications, :through => :recipients
  has_many :channels
  has_many :availabilities
  has_many :phones, -> { order(:priority) }
  has_many :emails, -> { order(:priority) }
  accepts_nested_attributes_for :channels, allow_destroy: true
  accepts_nested_attributes_for :phones, allow_destroy: true
  accepts_nested_attributes_for :emails, allow_destroy: true
  has_many :courses, through: :certs
  has_many :skills, through: :courses
  has_and_belongs_to_many :titles
  has_many :timecards
  has_many :events, through: :timecards
  has_many :items, inverse_of: :owner, foreign_key: :owner_id
  has_many :inspectors, foreign_key: :person_id, class_name: 'Inspection'
  has_many :activities, as: :loggable

  belongs_to :department

  validates_presence_of :firstname, :lastname, :status, :department, :title_order
  validates_uniqueness_of :icsid, allow_nil: true, allow_blank: true, case_sensitive: false   # this needs to be scoped to active members, or more sophisticated rules
  validates_length_of :state, is: 2, allow_nil: true, allow_blank: true
  validates_numericality_of  :height, :weight, allow_nil: true, allow_blank: true
  validates_presence_of :division2, unless: -> { division1.blank? }
  validates_presence_of :division1, unless: -> { division2.blank? }
  validates_chronology :start_date, :end_date

  validate :start_date_cannot_be_before_application_date, :check_zipcode

  scope :cert, -> { order("division1, division2, title_order, start_date ASC").where( department: "CERT" ) }
  scope :police, -> { order("division1, division2, title_order, start_date ASC").where( department: "Police" ) }
  scope :leave, -> { where( status: "Leave of Absence" ) }
  scope :inactive, -> { order("end_date ASC").where( status: "Inactive" ) }
  scope :active, -> { order("division1, division2, title_order, start_date ASC").where( status: "Active" ) }
  scope :applicants, -> { order("created_at ASC").where( status: "Applicant" ) }
  scope :prospects, -> { order("created_at ASC").where( status: "Prospect" ) }
  scope :declined, -> { order("created_at ASC").where( status: "Declined" ) }
  scope :divisionC, -> { order("title_order, start_date ASC").where( division1: "Command", status: "Active" ) }
  scope :division1, -> { order("title_order, start_date ASC").where( division1: "Division 1", status: "Active" ) }
  scope :division2, -> { order("title_order, start_date ASC").where( division1: "Division 2", status: "Active" ) }
  scope :squadC, -> { order("title_order, start_date ASC").where( division2: "Command", status: "Active" ) }
  scope :unassigned, -> { order("title_order, start_date ASC").where( division1: "Unassigned", status: "Active" ) }
  scope :squad1, -> { order("title_order, start_date ASC").where( division2: "Squad 1", status: "Active" ) }
  scope :squad2, -> { order("title_order, start_date ASC").where( division2: "Squad 2", status: "Active" ) }
  scope :of_dept, -> (department) { where(department: department) }

  scope :titled_equal_or_higher_than, lambda { |title|
    where('title_order <= ?',
          Person::TITLE_ORDER.fetch(title, DEFAULT_TITLE_ORDER))
  }

  TITLES = ['Director','Chief','Deputy','Captain', 'Lieutenant','Sargeant',
            'Corporal', 'Senior Officer', 'Officer', 'CERT Member', 'Dispatcher',
            'Recruit', 'Unknown']
  TITLE_ORDER = {'Director' => 1, 'Chief' => 3, 'Deputy' => 5,
                 'Captain' => 7, 'Lieutenant' => 9, 'Sargeant' => 11,
                 'Corporal' => 13, 'Senior Officer' => 15, 'Officer' => 17,
                 'CERT Member' => 19, 'Dispatcher' => 19,
                 'Student Officer' => 21, 'Recruit' => 23, 'Applicant' => 25, 'Unknown' => 100}
  DEFAULT_TITLE_ORDER = 100

  DIVISION1 = ['Division 1', 'Division 2', "Division 3", "Recruit", 'Command']
  DIVISION2 = ['Command', 'Squad 1', 'Squad 2']
  STATUS = ['Leave of Absence', 'Inactive', 'Active', 'Applicant','Prospect','Declined']
  DEPARTMENT = ['Police', 'CERT', 'Other']

  def to_s
    fullname
  end

  def fullname
    first_or_nickname = self.nickname.blank? ? self.firstname : self.nickname
    (first_or_nickname.camelize + " " +
    (self.middleinitial.nil? ? "" : self.middleinitial.camelize) + " " +
     self.lastname.camelize).squeeze(" ")
  end

  def <=>(other)
    self.fullname.downcase <=> other.fullname.downcase
  end

  def shortrank
    ranks = { 'Director' => 'Dir', 'Chief' => "Chief", "Deputy" => "Deputy", "Captain" => "Capt",
            "Lieutenant" => "Lt", "Sargeant" => "Sgt", "Corporal" => "Cpl",
            "Senior Officer" => "SrO", "Officer" => "Ofc", "Dispatcher" => "Dsp",
            "CERT Member" => "TM", "Recruit" => "Rct" }
    ranks[self.title] || ''
  end

  def name
    (self.firstname.camelize + " " + self.lastname.camelize)
  end

  def sar_level
    return 1 if self.skilled?("SAR Tech 1")
    return 2 if self.skilled?("SAR Tech 2")
    return 3 if self.skilled?("SAR Tech 3")
  end

  def phone
    phones.first.try(:content)
  end

  def email
    emails.first.try(:content)
  end

  def csz
    self.city + " " + self.state + " " + self.zipcode
  end

  def state=(value)
    # custom actions
    write_attribute(:state, value.strip.upcase)
  end

  def self.find_by_phone(phone_number)
    channel = Channel.where(content: phone_number).first
    channel.person if channel
  end

  def responded?(target)
    return false if !target.respond_to?(:start_time) || !target.respond_to?(:end_time) || self.availabilities.empty?
    self.availabilities.for_time_span(target.start_time..target.end_time).count > 0
  end

  def dept_shortname
    department ? department.shortname : "None"
  end

  def self.search(search)
    if search
      find :all, :conditions => ['firstname LIKE ? OR lastname LIKE ? OR city LIKE ? OR icsid like ?',
        "%#{search}%","%#{search}%","%#{search}%","%#{search}%"],
        :order => 'division1, division2,title_order, start_date ASC'
    else
      find :all, :order => 'division1, division2,title_order, start_date ASC'
    end
  end

  def self.each(&block)
    # FIXME: because all is deprecated in Active Record 4
    # http://guides.rubyonrails.org/active_record_querying.html#retrieving-multiple-objects
    # this class method will let us continue without changing every call site
    Person.find_each { |x| block.call(x) }
  end

  def age
    if self.date_of_birth.present?
      now = Date.today
      age = now.year - self.date_of_birth.year
      age -= 1 if now.yday < self.date_of_birth.yday
    end
      age
  end

  def skilled?(skill_name)
    skill = Skill.find_by_name(skill_name)
    if skill.blank?
      false
    else
      self.skills.include?(skill)
    end
  end

  def qualified?(title_name)
    title = Title.find_by_name(title_name)
    if title
      (title.skills - self.skills).empty?  # then true
    else
      false
    end
  end

  def missing_skills(title)
    return "Invalid title" unless title.kind_of?(Title)
    title.skills - self.skills
  end

  def date_last_responded
    a = availabilities.order(:created_at).last
    a ? a.created_at : Time.new(1980,1,1)
  end

  def date_last_available
    a = availabilities.available.in_the_past.order(:start_time).last
    a ? a.start_time : Time.new(1980,1,1)
  end

  def date_last_worked
    t = timecards.verified.order(:start_time).last
    t ? t.start_time : Time.new(1980,1,1)
  end

  def monthly_hours_going_back(x)
    timecards.where('start_time > ?', x.months.ago).sum(:duration).to_i.to_s
  end

  def service_duration
    if self.start_date.present?
      if self.end_date.present?
        self.end_date.year - self.start_date.year + ( self.start_date.yday < self.end_date.yday ? 1 : 0 )
      else
        Date.today.year - self.start_date.year + ( self.start_date.yday < Date.today.yday ? 1 : 0 )
      end
    end
  end

  def valid_skills
    skills.where("certs.expiration_date > ?", Time.zone.today)
  end

  def meets?(requirement)
    titles.include?(requirement.title)
  end

  def upcoming_events
    upcoming_events_count = Setting.get_integer('UPCOMING_EVENTS_COUNT', 10)

    self.department.events.upcoming.limit(upcoming_events_count)
  end

  private

  def calculate_title_order
    self.title_order = TITLE_ORDER[self.title].nil? ? DEFAULT_TITLE_ORDER : TITLE_ORDER[self.title]
  end

  def check_zipcode
    return unless zipcode.present? && !zipcode.match(/^(?:[1-9]|0(?!0{4}))\d{4}(?:[-\s]\d{4})?$/)
    errors.add(:zipcode, "use format - ex. 12345 or 12345-1234")
  end

  def start_date_cannot_be_before_application_date
    return unless start_date && application_date

    if start_date < application_date
      errors.add(:start_date, "cannot be before the application date")
    end
  end
end
