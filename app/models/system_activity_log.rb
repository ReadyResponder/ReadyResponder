class SystemActivityLog < ActiveRecord::Base
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

  has_paper_trail

  belongs_to :user

  validates :message, :category, presence: true

  scope :for_category, ->(category) { where(category: category) }
  scope :on_date, ->(date) { where("DATE(created_at) = ?", date) }
end
