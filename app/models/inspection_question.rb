class InspectionQuestion < ApplicationRecord
  belongs_to :inspection, optional: true
  belongs_to :question, optional: true
end
