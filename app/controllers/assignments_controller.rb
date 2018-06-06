class AssignmentsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  before_action :set_requirement, only: [:new, :create]
  before_action :set_assignment, only: [:show, :edit, :update, :destroy]

  def index
    @assignments = Assignment.all
  end

  def show
    @last_editor = last_editor(@assignment)
  end

  def new
    @assignment = Assignment.new
    @assignment.status = "New"
    @assignment.start_time = @requirement.start_time
    @assignment.end_time = @requirement.end_time
  end

  def edit
  end

  def create
    @assignment = @requirement.assignments.new(assignment_params)

    if @assignment.save
      redirect_to @requirement, notice: 'Assignment was successfully created.'
    else
      render :new
    end
  end

  def update
    if @assignment.update(assignment_params)
      redirect_to @assignment.requirement, notice: 'Assignment was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @assignment.destroy
    redirect_to assignments_url, notice: 'Assignment was successfully destroyed.'
  end

  private
  def set_assignment
    @assignment = Assignment.find(params[:id])
  end

  def set_requirement
    @requirement = Requirement.find(params[:requirement_id])
  end

  def assignment_params
    params.require(:assignment).permit(:person_id, :requirement_id, :start_time, :end_time, :status, :duration)
  end

end
