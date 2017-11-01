class Activity < ApplicationRecord
  belongs_to :loggable, polymorphic: true, optional: true
end
