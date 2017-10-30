class ItemType < ApplicationRecord
  has_paper_trail

  mount_uploader :item_type_image, ItemTypeImageUploader

  belongs_to :item_category, optional: true
  has_many :items

  validates_presence_of :item_category_id, :status, :name

  def to_s
    name
  end
end
