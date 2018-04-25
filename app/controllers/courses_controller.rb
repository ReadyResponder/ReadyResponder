class CoursesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @courses = Course.active
    @page_title = "All Courses"
  end

  def show
    @last_editor = last_editor(@course)
  end

  def new
    @course = Course.new
  end

  def edit
  end

  def create
    @course = Course.new(course_params)
    if @course.save
      redirect_to @course, notice: 'Course was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    if @course.update_attributes(course_params)
      redirect_to @course, notice: 'Course was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @course.destroy
  end

  private

  def course_params
    params.require(:course).permit(:category, :comments, :description, :duration, :status, :term, :name, skill_ids: [])
  end
end
