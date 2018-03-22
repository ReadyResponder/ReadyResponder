class ItemCategory < ActiveRecord::Base
  has_paper_trail
  include Loggable

  has_many :item_types
  has_many :taggings, :as => :taggable
  has_many :tags, :through => :taggings

  validates_presence_of :name, :status
  validates_uniqueness_of :name

  def to_s
    name
  end

end
