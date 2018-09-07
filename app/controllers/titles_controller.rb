class TitlesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @titles = Title.all
    @page_title = "All Titles"
  end

  def show
  end

  def new
    @title = Title.new
  end

  def edit
  end

  def create
    @title = Title.new(title_params)

    if @title.save
      redirect_to @title, notice: 'Title was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    if @title.update_attributes(title_params)
      redirect_to @title, notice: 'Title was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @title.destroy

    redirect_to titles_url
  end

  private

  def title_params
    params.require(:title).permit(:comments, :description, :status, :name, skill_ids: [])
  end
end
