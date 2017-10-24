class Comment < ActiveRecord::Base
  has_paper_trail

  belongs_to :commentable, :polymorphic => true

  default_scope ->{ order('created_at DESC') }

  validates_presence_of :description
end
