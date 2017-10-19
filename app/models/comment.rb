class Comment < ActiveRecord::Base
  belongs_to :commentable, :polymorphic => true

  default_scope ->{ order('created_at DESC') }

  validates_presence_of :person_id, :description
end
