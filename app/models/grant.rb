class Grant < ActiveRecord::Base
  has_many :items
  validates :name, :status, :start_date, :end_date, presence: true
  STATUS_CHOICES = %w(Pending Open Closed Expired)

end
