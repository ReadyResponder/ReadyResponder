class ItemTypesController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  # GET /item_types
  # GET /item_types.json
  def index
    @item_types = ItemType.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @item_types }
    end
  end

  # GET /item_types/1
  # GET /item_types/1.json
  def show
    @item_type = ItemType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @item_type }
    end
  end

  # GET /item_types/new
  # GET /item_types/new.json
  def new
    @item_type = ItemType.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @item_type }
    end
  end

  # GET /item_types/1/edit
  def edit
    @item_type = ItemType.find(params[:id])
  end

  # POST /item_types
  # POST /item_types.json
  def create
    @item_type = ItemType.new(item_type_params)

    respond_to do |format|
      if @item_type.save
        format.html { redirect_to @item_type, notice: 'Item type was successfully created.' }
        format.json { render json: @item_type, status: :created, location: @item_type }
      else
        format.html { render action: "new" }
        format.json { render json: @item_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /item_types/1
  # PATCH/PUT /item_types/1.json
  def update
    @item_type = ItemType.find(params[:id])

    respond_to do |format|
      if @item_type.update_attributes(item_type_params)
        format.html { redirect_to @item_type, notice: 'Item type was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @item_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /item_types/1
  # DELETE /item_types/1.json
  def destroy
    @item_type = ItemType.find(params[:id])
    @item_type.destroy

    respond_to do |format|
      format.html { redirect_to item_types_url }
      format.json { head :no_content }
    end
  end

  private

    # Use this method to whitelist the permissible parameters. Example:
    # params.require(:person).permit(:name, :age)
    # Also, you can specialize this method with per-user checking of permissible attributes.
    def item_type_params
      params.require(:item_type).permit(:is_a_group, :is_groupable, :name, :parent_id, :status)
    end
end
