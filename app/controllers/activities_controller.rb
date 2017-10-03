class ActivitiesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @activities = Activity.all
  end

  def show
    @last_editor = last_editor(@assignment)
  end

  def new
    @activity = Activity.new
  end

  def edit
  end

  def create
    @activity = Activity.new(activity_params)

    if @activity.save
      redirect_to @activity, notice: 'Activity was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    if @activity.update_attributes(activity_params)
      redirect_to @activity, notice: 'Activity was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @activity.destroy
    redirect_to activities_url
  end

  private
  def activity_params
    params.require(:activity).permit(:loggable_id, :loggable_type, :author, :content)
  end

end
