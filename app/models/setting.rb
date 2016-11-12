class Setting < ActiveRecord::Base

  validates_presence_of :name, :key, :value, :category, :status

  STATUS_CHOICES = ['Active', 'Inactive']
end
