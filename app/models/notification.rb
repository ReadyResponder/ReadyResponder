class Notification < ActiveRecord::Base
#  serialize :departments, Array
  has_paper_trail
  include Loggable

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
  validate :notification_has_at_least_one_recipient
  validates_presence_of :subject
  validates_uniqueness_of :id_code, unless: :expired?

  def available_statuses
    if status
      STATUS_STATES[status]
    else
      STATUS_STATES['New']
    end
  end

  def start_time
    self.event.start_time
  end

  def end_time
    self.event.end_time
  end

  def activate!
    self.start_time = Time.zone.now
    self.status = "In-Progress"
    self.save!
    Person.active.where(department: self.departments).each do |p|
      if (self.purpose == "FYI" ||
          self.purpose == "Acknowledgment" ||
          self.purpose == "Availability" && !p.responded?(self))
        recipients.create(person: p)
      end
    end
    notify!
  end

  def notify!
    if channels.include? "Text"
      twilio = Message::SendNotificationTextMessage.new
      recipients.each do |r|
        r.notify! twilio
      end
    end
  end

private

  def notification_has_at_least_one_recipient
    # As we add more ways to choose recipients,
    # we'll need to expand this validator
    if departments.blank?
      errors[:departments] << "All recipients can't be blank"
    end
  end

  def expired?
    Notification.where(id_code: id_code)
      .select { |notification| notification.end_time > 6.months.ago }.empty?
  end

end
