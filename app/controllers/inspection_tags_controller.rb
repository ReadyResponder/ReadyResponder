class InspectionTagsController < ApplicationController
  def index
    @inspection_tags = InspectionTag.all()
  end

  def new
    @inspection_tag = InspectionTag.new()
  end

  def create
    @inspection_tag = InspectionTag.new(inspection_tag_params)
    if @inspection_tag.save
      flash[:success] = "#{@inspection_tag.name} tag created"
      redirect_to action: :index
    else
      render :new
    end
  end

  private

  def inspection_tag_params
    params.require(:inspection_tag).permit(:name)
  end
end
