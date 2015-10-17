class Inspection < ActiveRecord::Base
  attr_accessible :inspection_date, :person_id, :status
  belongs_to :person
end

