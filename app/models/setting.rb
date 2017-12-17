class Setting < ActiveRecord::Base
  has_paper_trail
  include Loggable

  validates_presence_of :name, :key, :value, :category, :status

  MissingSettingError = Class.new(StandardError)

  STATUS_CHOICES = ['Active', 'Inactive']

  def self.get(key)
    return ENV[key] if ENV[key]
    value_object = Setting.where(key: key, status: "Active").first
    value_object.value if value_object
  end

  def active?
    self.status == 'Active'
  end

  def self.find_or_create_upcoming_events_setting(options = {})
    find_or_create_with_defaults('UPCOMING_EVENTS_COUNT', {
      :name => 'Upcoming events count',
      :value => 10,
      :category => 'Person',
      :status => 'Active',
      }.merge(options))
  end

  def self.find_or_create_with_defaults(key, options = {})
    create_with(options).find_or_create_by!(:key => key)
  end
  
end
