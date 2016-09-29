class Task < ActiveRecord::Base
  belongs_to :event
  validates :event, presence: true
  validates :title, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates_chronology :start_time, :end_time

  # has_many :requirements
  # has_many :assignments, through: :requirements

  STATUS_CHOICES_ARRAY = ['Empty', 'Partially Filled', 'Full', 'Cancelled']

  # The following provides the equivalent of:
  # STATUS_CHOICES = { 'Empty' => 0, 'Partially Filled' => 1, 'Full' => 2, 'Cancelled' => 3 }
  # This is used to give a sortable numeric value based on the order of the above array.
  STATUS_CHOICES = STATUS_CHOICES_ARRAY.map.with_index { |v, i| [v, i] }.to_h

  def status
    # (set and) return a random status for testing.
    @stub_status ||= STATUS_CHOICES.keys[rand(STATUS_CHOICES.count)]
    return @stub_status
  end

  def status_value
    # return a value for sorting
    return STATUS_CHOICES[status]
  end

  def requirements
    # (set and) return a random number of requirements
    @stub_requirements ||= rand(25) + 2
    return @stub_requirements
  end

  def requirements_met
    # (set and) return a random number of requirements met
    @stub_requirements_met ||= requirements_met_for_stub
    return @stub_requirements_met
  end

  def requirements_unmet
    return requirements - requirements_met
  end

  private
  def requirements_met_for_stub
    # generate a value compatible with status
    case status
    when 'Full'
      return requirements
    when 'Empty'
      return 0
    when 'Cancelled' # Can have any value from 0 to total number of requirements
      return rand(requirements + 1)
    else # 'Partially Filled' can have any value but full or 0.
      return 1 + rand(requirements - 1)
    end
  end
end
