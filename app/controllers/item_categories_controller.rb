class ItemCategoriesController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  
  before_action :set_item_category, only: [:show, :edit, :update, :destroy]

  # GET /item_categories
  def index
    @item_categories = ItemCategory.all
  end

  # GET /item_categories/1
  def show
    @last_editor = last_editor(@item_category)
  end

  # GET /item_categories/new
  def new
    @item_category = ItemCategory.new
  end

  # GET /item_categories/1/edit
  def edit
  end

  # POST /item_categories
  def create
    @item_category = ItemCategory.new(item_category_params)

    if @item_category.save
      redirect_to @item_category, notice: 'Item category was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /item_categories/1
  def update
    if @item_category.update(item_category_params)
      redirect_to @item_category, notice: 'Item category was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /item_categories/1
  def destroy
    @item_category.destroy
    redirect_to item_categories_url, notice: 'Item category was successfully destroyed.'
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_item_category
    @item_category = ItemCategory.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def item_category_params
    params.require(:item_category).permit(:name, :status, :description, :department_id)
  end
end
