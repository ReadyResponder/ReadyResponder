class ItemType < ActiveRecord::Base
  attr_accessible :is_a_group, :is_groupable, :name, :parent_id, :status
  has_many :items

end
