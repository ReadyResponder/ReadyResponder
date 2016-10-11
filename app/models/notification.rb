class Notification < ActiveRecord::Base
  belongs_to :event
  # has_many :recipients

  validates :status, inclusion: { in: %w(pending active canceled complete expired) }
end
