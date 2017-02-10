class ItemCategory < ActiveRecord::Base
  has_paper_trail

  belongs_to :department
  has_many :item_types

  validates_presence_of :name, :status
  validates_uniqueness_of :name, scope: :department_id

  def to_s
    name
  end
  
  def department_name
    return department.name if department
    return "Unknown Department"
  end
end
