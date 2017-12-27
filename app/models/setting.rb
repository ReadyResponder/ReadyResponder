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

  def self.get_value(key, fallback_value = nil)    
    value = get(key)
    (Integer value rescue value) || fallback_value
  end
  
end
