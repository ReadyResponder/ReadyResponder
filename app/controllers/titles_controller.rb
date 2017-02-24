class TitlesController < ApplicationController
  before_filter :authenticate_user!
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
    @title = Title.new(params[:title])

    if @title.save
      redirect_to @title, notice: 'Title was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    if @title.update_attributes(params[:title])
      redirect_to @title, notice: 'Title was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @title.destroy

    redirect_to titles_url
  end
end
