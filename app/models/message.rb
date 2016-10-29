class Message < ActiveRecord::Base
  belongs_to :recipient
  belongs_to :channel
end
