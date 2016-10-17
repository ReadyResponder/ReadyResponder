class Notification < ActiveRecord::Base
  belongs_to :event
  # has_many :recipients

  VALID_STATUSES = %w(pending active canceled complete expired)
  validates :status, inclusion: { in: VALID_STATUSES }


end
