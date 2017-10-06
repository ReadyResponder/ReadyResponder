class Comment < ActiveRecord::Base
  belongs_to :commentable, :polymorphic => true

  scope :recent, ->{ order('created_at DESC') }
end
