class SystemActivityLog < ActiveRecord::Base
  has_paper_trail

  belongs_to :user

  validates :message, :category, presence: true
end
