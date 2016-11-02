class Notification < ActiveRecord::Base
  belongs_to :event
  # has_many :recipients

  STATUS_STATES = {
    'New' => ['Scheduled', 'Active'],
    'Scheduled' => ['Active', "Cancelled"],
    'Active' => ['Cancelled'],
    'In-Progress' => ['Cancelled'],
    'Cancelled' => [],
    'Complete' => [],
    'Expired' => []
  }

  def available_statuses
    if status
      STATUS_STATES[status]
    else
      STATUS_STATES['New']
    end
  end

end
