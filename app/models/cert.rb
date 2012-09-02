class Cert < ActiveRecord::Base
  attr_accessible :category, :comments, :course_id, :expiration_date, :issued_date, :cert_number, :level, :person_id, :status, :certification
  belongs_to :person
  belongs_to :course
  mount_uploader :certification, CertificationUploader
  before_save :set_defaults
  validates_presence_of :person_id, :course_id, :status, :issued_date
  
  private
  
  def set_defaults
    if self.expiration_date.blank? then
      #course = Course.find(self.course_id)
      self.expiration_date = self.issued_date + course.term.to_i.months unless course.nil?
    end
  end

end
