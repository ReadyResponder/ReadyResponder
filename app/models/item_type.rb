class ItemType < ActiveRecord::Base
  has_paper_trail
  include Loggable

  attr_accessible :is_a_group, :is_groupable, :name, :parent_id, :status,
    :description, :item_category_id, :item_type_image

  mount_uploader :item_type_image, ItemTypeImageUploader

  belongs_to :item_category
  has_many :items

  validates_presence_of :item_category_id, :status, :name

  def to_s
    name
  end
end
