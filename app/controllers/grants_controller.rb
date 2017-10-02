class GrantsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  def index
    @grants = Grant.all
    @page_title = "All Grants"
  end

  def show
    @page_title = "Grant: #{@grant.name}"
  end

  def new
    @grant = Grant.new
    @page_title = "New Grant"
  end

  def edit
    @page_title = "Grant: #{@grant.name}"
  end

  def create
    @grant = Grant.new(grant_params)

    if @grant.save
      redirect_to @grant, notice: 'Grant was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    if @grant.update_attributes(grant_params)
      redirect_to @grant, notice: 'Grant was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @grant.destroy
    redirect_to grants_path
  end

  private

  def grant_params
    params.require(:grant).permit(:name, :description, :start_date, :end_date)
  end

end
