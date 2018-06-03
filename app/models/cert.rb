class Cert < ActiveRecord::Base
  has_paper_trail
  include Loggable

  attr_accessible :category, :person_id, :courses, :expiration_date, :issued_date, :cert_number, :level,  :status, :certification, :comments
  belongs_to :person
  has_and_belongs_to_many :courses
  mount_uploader :certification, CertificationUploader
  before_save :set_defaults
  validates_presence_of :status, :person_id, :issued_date
  validates_chronology :issued_date, :expiration_date
  validate :require_at_least_one_course

  scope :active, -> { where( expired: false ) }

  def expiring?
    #self.expiration_date <= 10.days.from_now #&& !(self.expiration_date <= Date.today)
    false
  end

  def expired?
    self.expiration_date <= Date.today
  end

  def self.active
    where("expiration_date > ?", Date.today)
  end
  private

  def set_defaults
    if self.expiration_date.blank? then
      self.expiration_date = self.issued_date + course.term.to_i.months unless course.nil?
    end
  end

  def require_at_least_one_course
    if courses.count == 0
      errors.add_to_base "Please select at least one course"
    end
  end
end
