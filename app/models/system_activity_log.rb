class SystemActivityLog < ApplicationRecord
  has_paper_trail
  # rails 5 deprecation
  # attr_accessible :user, :message, :category
  belongs_to :user

  LOGGED_MODELS = [
    "Assignment",
    "Availability",
    "Cert",
    "Channel",
    "Comment",
    "Course",
    "Department",
    "Event",
    "Grant",
    "InspectionQuestion",
    "Inspection",
    "ItemCategory",
    "ItemType",
    "Item",
    "Location",
    "Notification",
    "Person",
    "Question",
    "Repair",
    "Requirement",
    "Setting",
    "Skill",
    "Task",
    "Timecard",
    "Title",
    "UniqueId",
    "User"
  ]

  validates :message, :category, presence: true

  scope :for_category, ->(category) { where(category: category) }
  scope :on_date, ->(date) { where("DATE(created_at) = ?", date) }
end
