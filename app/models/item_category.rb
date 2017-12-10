class ItemCategory < ActiveRecord::Base
  has_paper_trail
  include Loggable

  has_many :item_types

  validates_presence_of :name, :status
  validates_uniqueness_of :name

  def to_s
    name
  end

end
