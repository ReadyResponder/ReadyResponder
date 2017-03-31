class InspectionsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  
  before_action :set_item, only: [:new, :create]
  before_action :set_inspection, only: [:show, :edit, :update, :destroy]

  def index
    @inspections = Inspection.all
  end

  def show
  end

  def new
    @inspection = @item.inspections.build
  end

  def edit
  end

  def create
    @inspection = @item.inspections.build(inspection_params)
    if @inspection.save
      redirect_to @inspection.item, notice: 'Inspection was successfully created.'
    else
      render 'new'
    end
  end

  def update
    if @inspection.update(inspection_params)
      redirect_to @inspection.item, notice: 'Inspection was successfully updated.'
    else
      render 'edit'
    end
  end

  def destroy
    @inspection.destroy
    redirect_to inspections_url
  end

  private
  def set_item
    @item = Item.find(params[:item_id])
  end

  def set_inspection
    @inspection = Inspection.find(params[:id])
  end

  def inspection_params
    params.require(:inspection).permit(:inspection_date, :status, :comments)
  end
end
