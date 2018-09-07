class Activity < ApplicationRecord
  # rails 5 deprecated this and recommends using strong parameters
  # attr_accessible :author, :content, :loggable_id, :loggable_type
  belongs_to :loggable, polymorphic: true
end
