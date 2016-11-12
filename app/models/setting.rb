class Setting < ActiveRecord::Base

  attr_accessible :name, :description, :key, :value, :category, :status, :required
  validates_presence_of :name, :key, :value, :category, :status

  STATUS_CHOICES = ['Active', 'Inactive']
end
