class DepartmentsController < ApplicationController
  before_filter :authenticate_user!
  before_action :format_divisions, :only => [:create, :update]
  before_action :set_department, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource

  def index
    @departments = Department.all
    @page_title = "All Departments"
  end

  def show
  end

  def new
    @department = Department.new
    @page_title = "New Department"
  end

  def edit
  end

  def create
    @department = Department.new(department_params)
    if @department.save
      redirect_to @department, notice: 'Department successfully created.'
    else
      render action: "new"
    end
  end

  def update
    if @department.update_attributes(department_params)
      redirect_to @department, notice: 'Department successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @department.destroy
    redirect_to departments_url, notice: 'Department successfully destroyed.'
  end

  private

  # Takes the passed in CSV and converts it into an array that removes any leading/trailing whitespace on each item
  def format_divisions
    params[:department][:division1] = params[:department][:division1].split(',').map{|x| x.chomp.lstrip}
    params[:department][:division2] = params[:department][:division2].split(',').map{|x| x.chomp.lstrip}
  end

  def set_department
    @department = Department.find(params[:id])
    @page_title = "Dept: #{@department.name}"
  end

  def department_params
    params.require(:department).permit(:name, :shortname, :status,
      :contact_id, :description, :manage_items, :manage_people,
      :division1 => [], :division2 => [])
  end
end
