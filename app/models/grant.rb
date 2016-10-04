class Grant < ActiveRecord::Base
  has_many :items, dependent: :destroy

  validates :name, :description, :start_date, :end_date, presence: true
end
