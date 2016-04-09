class UniqueId < ActiveRecord::Base
  belongs_to :item
  attr_accessible :category, :status, :value, :item
end
