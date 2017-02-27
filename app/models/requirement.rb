class Requirement < ActiveRecord::Base
  belongs_to :task
  belongs_to :skill
  belongs_to :title
  has_many :assignments

  validates :task, presence: true

  # validates :skill, presence: title.blank?
  # validates :title, presence: skill.blank?
  validate  :valid_title_or_skill

  validates :minimum_people, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :maximum_people, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :desired_people, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validate :valid_people_numbers

  STATUS_CHOICES_ARRAY = ['Empty', 'Inadequate', 'Adequate', 'Satisfied', 'Full']
  STATUS_CHOICES = STATUS_CHOICES_ARRAY.map.with_index { |v, i| [v, i] }.to_h

  PRIORITIES = [['High', 1], ['Medium', 2], ['Low', 3]]

  def priority_str
    PRIORITIES[priority - 1][0] if priority.present?
  end

  def to_s
    return title if title.present?
    return skill if skill.present?
    "Error"
  end

  def status
    case
    when number_filled >= maximum_people
      return 'Full'
    when number_filled >= desired_people
      return 'Satisfied'
    when number_filled >= minimum_people
      return 'Adequate'
    when number_filled > 0
      return 'Inadequate'
    else # number_filled == 0
      return 'Empty'
    end
  end

  def status_value
    # return a value for sorting
    return STATUS_CHOICES[status]
  end

  def met?
    true if ["Adequate", "Satisfied", "Full"].include? status
  end

  def number_filled
    assignments.active.count
  end

  private
    def valid_people_numbers
      if (minimum_people.present? and maximum_people.present? and desired_people.present?)
        if maximum_people < minimum_people
          errors.add(:maximum_people, "must be greater-than or equal to 'minumum_people")
        end
        if desired_people < minimum_people
          errors.add(:desired_people, "must be greater-than or equal to 'minumum_people")
        end
        if desired_people > maximum_people
          errors.add(:desired_people, "must be less-than or equal to 'maxumum_people")
        end
      end
    end

    def valid_title_or_skill
      if title.blank? && skill.blank?
        errors.add(:title, "must have a title or a skill")
        errors.add(:skill, "must have a title or a skill")
      end
    end
end
