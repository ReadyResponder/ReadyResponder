class Activity < ActiveRecord::Base
  attr_accessible :author, :content, :loggable_id, :loggable_type
  belongs_to :loggable, polymorphic: true
end

