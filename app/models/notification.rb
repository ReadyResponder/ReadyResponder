class Notification < ActiveRecord::Base
#  serialize :departments, Array
  has_and_belongs_to_many :departments
  belongs_to :event
  has_many :recipients
  has_many :people, :through => :recipients

  STATUS_STATES = {
    'New' => ['Scheduled', 'Active'],
    'Scheduled' => ['Active', "Cancelled"],
    'Active' => ['Cancelled'],
    'In-Progress' => ['Cancelled'],
    'Cancelled' => [],
    'Complete' => [],
    'Expired' => []
  }

  VALID_STATUSES = STATUS_STATES.keys
  validates :status, inclusion: { in: VALID_STATUSES }

  def available_statuses
    if status
      STATUS_STATES[status]
    else
      STATUS_STATES['New']
    end
  end

end
