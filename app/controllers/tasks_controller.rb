class TasksController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  before_action :set_event, only: [:new, :create]
  before_action :set_task, only: [:show, :edit, :update, :destroy]

  def index
    @tasks = Task.all
  end

  def show
    @page_title = @task.title
    @last_editor = last_editor(@task)
  end

  def new
    @task = @event.tasks.build
    @task.status = 'Active'
  end

  def create
    @task = @event.tasks.build(task_params)
    if @task.save
      redirect_to @task.event, notice: 'Task was successfully created.'
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @task.update(task_params)
      redirect_to @task.event, notice: 'Task was successfully updated.'
    else
      render 'edit'
    end
  end

  def destroy
    event = @task.event
    @task.destroy
    redirect_to event
  end

  private
    def set_event
      @event = Event.find(params[:event_id])
    end

    def set_task
      @task = Task.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:title, :priority, :description, :status,
                              :location, :street, :city, :state, :zipcode,
                              :latitude, :longitude, :start_time, :end_time)
    end
end
