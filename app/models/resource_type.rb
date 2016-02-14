class ResourceType < ActiveRecord::Base
  attr_accessible :description, :fema_code, :fema_kind, :name, :status
end
