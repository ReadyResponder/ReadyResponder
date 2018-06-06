class Message < ApplicationRecord
  belongs_to :recipient
  belongs_to :channel
end
