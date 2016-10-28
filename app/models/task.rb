class Task < ActiveRecord::Base
  belongs_to :event
  validates :event, presence: true
  validates :title, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates_chronology :start_time, :end_time

  has_many :requirements
  # has_many :assignments, through: :requirements

  # The following provides the equivalent of:
  # STATUS_CHOICES = { 'Empty' => 0, 'Inadequate' => 1, 'Adequate' => 2, 'Satisfied' => 3, 'Full' => 4, 'Cancelled' => 5 }
  STATUS_CHOICES_ARRAY = ['Empty', 'Inadequate', 'Adequate', 'Satisfied', 'Full', 'Cancelled']
  STATUS_CHOICES = STATUS_CHOICES_ARRAY.map.with_index { |v, i| [v, i] }.to_h

  PRIORITIES = [['High', 1], ['Medium', 2], ['Low', 3]]

  def priority_str
    PRIORITIES[priority - 1][0] if priority.present?
  end

  def status
    # (set and) return a random status for testing.
    @stub_status ||= STATUS_CHOICES.keys[rand(STATUS_CHOICES.count)]
    return @stub_status
  end

  def status_value
    # return a value for sorting
    return STATUS_CHOICES[status]
  end

  def requirements_count
    return requirements.count
    # (set and) return a random number of requirements
    # @stub_requirements_count ||= rand(25) + 2
    # return @stub_requirements_count
  end

  def requirements_met_count
    # (set and) return a random number of requirements met
    @stub_requirements_met_count ||= requirements_met_for_stub
    return @stub_requirements_met_count
  end

  def requirements_unmet_count
    return requirements_count - requirements_met_count
  end

  def location
    return self[:location] if self[:location].present?
    return self.event.location
  end

  private
    def requirements_met_for_stub
      # generate a value compatible with status
      case status
      when 'Full'
        return requirements_count
      when 'Empty'
        return 0
      when 'Cancelled' # Can have any value from 0 to total number of requirements
        return rand(requirements_count + 1)
      else # 'Partially Filled' can have any value but full or 0.
        return 1 + rand(requirements_count - 1)
      end
    end
end
