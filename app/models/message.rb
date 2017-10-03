class Message < ApplicationRecord
  belongs_to :recipient, optional: true
  belongs_to :channel, optional: true
end
