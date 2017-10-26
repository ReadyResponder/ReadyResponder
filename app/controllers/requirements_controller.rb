class RequirementsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  before_action :set_task, only: [:new, :create]
  before_action :set_requirement, only: [:show, :edit, :update, :destroy]

  def index
    # likely only for debugging
    @requirements = Requirement.all
  end

  def show
  end

  def new
    @requirement = @task.requirements.build
  end

  def create
    @requirement = @task.requirements.build(requirement_params)
    if @requirement.save
      redirect_to @requirement.task, notice: 'Requirement was successfully created.'
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @requirement.update(requirement_params)
      redirect_to @requirement.task, notice: 'Requirement was successfully created.'
    else
      render 'new'
    end
  end

  def destroy
    task = @requirement.task
    @requirement.destroy
    redirect_to task
  end

  private
    def set_task
      @task = Task.find(params[:task_id])
    end

    def set_requirement
      @requirement = Requirement.find(params[:id])
    end

    def requirement_params
      params.require(:requirement).permit(:title_id, :skill_id, :priority, :desired_people, :minimum_people,
        :maximum_people, :optional, :floating)
    end
end
