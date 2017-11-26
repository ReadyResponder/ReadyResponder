class SystemActivityLog < ActiveRecord::Base
  has_paper_trail

  belongs_to :user

  validates :message, :category, presence: true

  scope :for_category, ->(category) { where(category: category) }
  scope :on_date, ->(date) { where("DATE(created_at) = ?", date) }
end
