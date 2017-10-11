class Comment < ActiveRecord::Base
  belongs_to :commentable, :polymorphic => true

  scope :recent, ->{ order('created_at DESC') }

  validates_presence_of :person_id, :description
end
