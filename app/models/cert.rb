class Cert < ActiveRecord::Base
  attr_accessible :category, :comments, :course_id, :date_expires, :date_issued, :id_number, :instructor_id, :level, :person_id, :status
  belongs_to :person
  belongs_to :course
  #belongs_to :instructor #need something like :class => :person here to show where to look
end
