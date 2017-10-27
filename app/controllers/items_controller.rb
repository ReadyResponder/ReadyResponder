class ItemsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @items = Item.all
    @page_title = "All Items"
  end

  def show
    @last_editor = last_editor(@item)
    @page_title = "Item: #{@item.name}"
  end

  def new
    @item_type = ItemType.find( item_params[:item_type_id])
    @item = Item.new(
            status: 'Unassigned',
            condition: 'Ready',
            qty: 1,
            item_type_id: item_params[:item_type_id])

    @page_title = "New Item"
  end

  def edit
    @page_title = "Editing Item #{@item.name}"
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to @item, notice: 'Item was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    @item = Item.find(params[:id])
    if @item.update_attributes(item_params)
      redirect_to @item, notice: 'Item was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    format.html { redirect_to items_url }
  end

  private
  def item_params
    params.require(:item).permit(:category, :description, :location_id, :qty, :model, :brand, :name,
      :owner_id, :po_number, :value, :grant, :purchase_amt, :purchase_date, :sell_amt, :sell_date,
      :stock_number, :source, :status, :condition, :comments, :item_image, :department_id, :resource_type_id,
      :item_type_id, :unique_ids_attributes)
end
