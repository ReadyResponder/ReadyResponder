class ChannelsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def create
    comment = Comment.new(comment_params)
  end

  private

  def comment_params
    params.require(:comment).permit(:description, :person_id)
  end
end
