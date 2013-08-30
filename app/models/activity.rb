class Activity < ActiveRecord::Base
  attr_accessible :author, :content, :loggable_id, :loggable_type
end
