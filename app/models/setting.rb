class Setting < ActiveRecord::Base
  has_paper_trail

  validates_presence_of :name, :key, :value, :category, :status

  MissingSettingError = Class.new(StandardError)

  STATUS_CHOICES = ['Active', 'Inactive']

  def self.get(key)
    return ENV[key] if ENV[key]
    value_object = Setting.where(key: key, status: "Active").first
    value_object.value if value_object
  end
end
