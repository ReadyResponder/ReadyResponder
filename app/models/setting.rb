class Setting < ActiveRecord::Base

  validates_presence_of :name, :key, :value, :category, :status

  STATUS_CHOICES = ['Active', 'Inactive']

  def self.get(key)
    value = ENV[key]
    value_object = Setting.where(key: key, status: "Active").first if value.blank?
    value_object.value
  end
end
