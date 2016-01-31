class InspectionQuestion < ActiveRecord::Base
  belongs_to :inspection
  belongs_to :question
end
