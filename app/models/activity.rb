class Activity < ApplicationRecord
  # TODO => USE STRONG PARAMETERS
  # attr_accessible :author, :content, :loggable_id, :loggable_type
  belongs_to :loggable, polymorphic: true, optional: true
end
