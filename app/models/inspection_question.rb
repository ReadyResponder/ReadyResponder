class InspectionQuestion < ActiveRecord::Base
  has_paper_trail

  belongs_to :inspection
  belongs_to :question
end
