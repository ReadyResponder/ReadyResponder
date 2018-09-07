class Comment < ApplicationRecord
  has_paper_trail
  include Loggable

  belongs_to :commentable, :polymorphic => true

  default_scope ->{ order('created_at DESC') }

  validates_presence_of :description
end
