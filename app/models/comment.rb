class Comment < ActiveRecord::Base
  has_paper_trail

  belongs_to :commentable, :polymorphic => true
end
