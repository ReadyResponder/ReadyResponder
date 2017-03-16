class Task < ActiveRecord::Base
  belongs_to :event
  validates :event, presence: true
  validates :title, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates_chronology :start_time, :end_time

  has_many :requirements
  has_many :assignments, through: :requirements
  has_many :people, through: :assignments

  # The following provides the equivalent of:
  # STATUS_CHOICES = { 'Empty' => 0, 'Inadequate' => 1, 'Adequate' => 2, 'Satisfied' => 3, 'Full' => 4, 'Cancelled' => 5 }
  STATUS_CHOICES_ARRAY = ['Empty', 'Inadequate', 'Adequate', 'Satisfied', 'Full', 'Cancelled']
  STATUS_CHOICES = STATUS_CHOICES_ARRAY.map.with_index { |v, i| [v, i] }.to_h

  PRIORITIES = [['High', 1], ['Medium', 2], ['Low', 3]]

  def priority_str
    PRIORITIES[priority - 1][0] if priority.present?
  end

  def assignees
    folks = Array.new
    requirements.each do |requirement|
      folks << requirement.assignments.active.map { |a| a.person }
    end
    folks.flatten!.uniq if folks.present?
    return folks
  end

  def to_s
    title
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
    # TODO This will be an initial pass.
    # The results will not correctly look at a requirement lasting
    # more than one operational period.
    requirements.inject(0) { |sum, req| sum + (req.met? ? 1 : 0) }
  end

  def requirements_unmet_count
    return requirements_count - requirements_met_count
  end

  def location
    return self[:location] if self[:location].present?
    return self.event.location
  end

  private

end
