class Person < ActiveRecord::Base
  #code to get next un-used id # in the 800 range
  #((801...900).to_a - (array_from_db_of_taken_numbers))[0]
  attr_accessible :firstname, :lastname, :gender, :date_of_birth, :zipcode, :city, :state, :status, :end_date, :department, :icsid, :title, :title_ids, :start_date, :division1, :division2, :comments
  attr_accessible :channels_attributes

  has_many :channels, :autosave => true, :inverse_of => :person, :dependent => :destroy
  accepts_nested_attributes_for :channels, :reject_if => :all_blank, :allow_destroy => true
  before_save :title_order

  #Having a condition on this association allows all the chaining magic to happen.
  #Could I use a named scope, and/or could I have another association for 'active_certs' ?
  has_many :certs, :conditions => {:status =>'Active' }

  # Since phones and emails derive off of channels, is "has_many :channels" below redundant?

  has_many :courses, :through => :certs
  has_many :skills, :through => :courses
  has_and_belongs_to_many :titles
  has_many :timecards
  has_many :events, :through => :timecards
  has_many :items
  has_many :inspections
  has_many :activities, as: :loggable

  validates_presence_of :firstname, :lastname, :status
  validates_uniqueness_of :icsid, :allow_nil => true, :allow_blank => true   # this needs to be scoped to active members, or more sophisticated rules
  validates :firstname, :uniqueness => { :scope => :lastname }
  validates_length_of :state, :is =>2, :allow_nil => true, :allow_blank => true
  validates_numericality_of  :height, :weight, :allow_nil => true, :allow_blank => true
  validates_presence_of :division2, :unless => "division1.blank?"
  validates_presence_of :division1, :unless => "division2.blank?"

  scope :cert, :order => 'division1, division2, title_order, start_date ASC', :conditions => {:department => "CERT"}
  scope :police, :order => 'division1, division2, title_order, start_date ASC', :conditions => {:department => 'Police'}
  scope :leave, :conditions => {:status => "Leave of Absence"}
  scope :inactive, :order => 'end_date ASC',:conditions => {:status => "Inactive"}
  scope :active, :order => 'division1, division2, title_order, start_date ASC', :conditions => {:status => "Active"}
  scope :applicants, :order => 'created_at ASC', :conditions => {:status => "Applicant"}
  scope :prospects, :order => 'created_at ASC', :conditions => {:status => "Prospect"}
  scope :declined, :order => 'created_at ASC', :conditions => {:status => "Declined"}
  scope :divisionC, :order => 'title_order, start_date ASC', :conditions => {:division1 => "Command", :status => "Active"}
  scope :division1, :order => 'title_order, start_date ASC', :conditions => {:division1 => "Division 1", :status => "Active"}
  scope :division2, :order => 'title_order, start_date ASC', :conditions => {:division1 => "Division 2", :status => "Active"}
  scope :squadC, :order => 'title_order, start_date ASC', :conditions => {:division2 => "Command", :status => "Active"}
  scope :unassigned, :order => 'title_order, start_date ASC', :conditions => {:division1 => "Unassigned", :status => "Active"}
  scope :squad1, :order => 'title_order, start_date ASC', :conditions => {:division2 => "Squad 1",:status => "Active"}
  scope :squad2, :order => 'title_order, start_date ASC', :conditions => {:division2 => "Squad 2",:status => "Active"}

  TITLES = ['Director','Chief','Deputy','Captain', 'Lieutenant','Sargeant', 'Corporal', 'Senior Officer', 'Officer', 'CERT Member', 'Dispatcher', 'Recruit']
  TITLE_ORDER = {'Director' => 1, 'Chief' => 3, 'Deputy Chief' => 5,'Captain' => 7, 'Lieutenant' => 9, 'Sargeant' => 11, 'Corporal' => 13, 'Senior Officer' => 15, 'Officer' => 17, 'CERT Member' => 19, 'Dispatcher' => 19, 'Student Officer' => 21, 'Recruit' => 23, 'Applicant' => 25}
  DIVISION1 = ['Division 1', 'Division 2', 'Command']
  DIVISION2 = ['Command', 'Squad 1', 'Squad 2', 'CERT']
  STATUS = ['Leave of Absence', 'Inactive', 'Active', 'Applicant','Prospect','Declined']
  DEPARTMENT = ['Police', 'CERT', 'Other']

  def fullname
    fname = self.nickname ||= self.firstname
    (fname + " " + (self.middleinitial || "") + " " + self.lastname).squeeze(" ")
  end

  def shortrank
    ranks = { 'Director' => 'Dir', 'Chief' => "Chief", "Deputy Chief" => "Deputy", "Captain" => "Capt",
            "Lieutenant" => "Lt", "Sargeant" => "Sgt", "Corporal" => "Cpl",
            "Senior Officer" => "SrO", "Officer" => "Ofc", "Dispatcher" => "Dsp",
            "CERT Member" => "TM", "Recruit" => "Rct" }
    ranks[self.title] || ''
  end

  def title_order
    self.title_order = TITLE_ORDER[self.title] || 30
  end

  def name
    (self.firstname + " " + self.lastname)
  end

  def sar_level
    return 1 if self.skilled?("SAR Tech 1")
    return 2 if self.skilled?("SAR Tech 2")
    return 3 if self.skilled?("SAR Tech 3")
  end

  def phones
    channels.where(:type => ["Cell", "Landline", "Phone"]).order(:priority)
  end

  def phone
    phones.first.content if phones.present?
  end

  def emails
    channels.where(:type => "Email").order(:priority)
  end

  def email
    emails.first.content if emails.present?
  end

  def csz
    self.city + " " + self.state + " " + self.zipcode
  end

  def state=(value)
    # custom actions
    write_attribute(:state, value.strip.upcase)
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

  def service_duration
    if self.start_date.present?
      if self.end_date.present?
        self.end_date.year - self.start_date.year + ( self.start_date.yday < self.end_date.yday ? 1 : 0 )
      else
        Date.today.year - self.start_date.year + ( self.start_date.yday < Date.today.yday ? 1 : 0 )
      end
    end
  end
end

