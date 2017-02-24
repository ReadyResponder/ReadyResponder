class TitlesController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  def index
    @titles = Title.all
    @page_title = "All Titles"
  end

  def show
    @title = Title.find(params[:id])
  end

  def new
    @title = Title.new
  end

  def edit
    @title = Title.find(params[:id])
  end

  def create
    @title = Title.new(params[:title])

    if @title.save
      redirect_to @title, notice: 'Title was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    @title = Title.find(params[:id])

    if @title.update_attributes(params[:title])
      redirect_to @title, notice: 'Title was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @title = Title.find(params[:id])
    @title.destroy

    redirect_to titles_url
  end
end
