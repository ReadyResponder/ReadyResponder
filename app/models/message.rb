class Message < ActiveRecord::Base
  attr_accessible :body, :channels, :created_by, :sent_at, :status, :subject
end
