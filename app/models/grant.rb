class Grant < ActiveRecord::Base
  validates :name, :description, :start_date, :end_date, presence: true
end
