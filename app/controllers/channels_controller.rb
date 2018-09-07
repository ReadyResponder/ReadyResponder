class ChannelsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @channels = Channel.all
  end

  def show
    @last_editor = last_editor(@channel)
  end

  def new
    @channel = Channel.new
  end

  def edit
  end

  def create
    @channel = Channel.new(params[:channel])

    if @channel.save
      redirect_to @channel, notice: 'Channel was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    if @channel.update_attributes(params[:channel])
      redirect_to @channel, notice: 'Channel was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @channel.destroy
  end
end
