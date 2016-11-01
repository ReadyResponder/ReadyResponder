class Recipient < ActiveRecord::Base
  belongs_to :notification
  belongs_to :person
  has_many :messages
end
