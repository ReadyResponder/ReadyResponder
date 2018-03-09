class VendorsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  def index
    @vendors = Vendor.all
  end

  def show
    @items = @vendor.items
  end

  def new
    @vendor = Vendor.new
  end

  def create
    @vendor = Vendor.new(vendor_params)

    if @vendor.save
      redirect_to params[:next] || vendors_path, notice: "Vendor was successfully created"
    else
      render action: new
    end
  end

  def edit
    @vendor = Vendor.find(params[:id])
  end

  def update
    @vendor = Vendor.find(params[:id])

    if @vendor.update_attributes(vendor_params)
      redirect_to vendor_path(@vendor), notice: "Vendor was successfully created"
    else
      flash[:alert] = @venor.error.full_messages.join(", ")
      render action: edit
    end
  end

  private

  def vendor_params
    params.require(:vendor).permit(:id, :name, :street, :city, :state, :zipcode, :status, :comments)
  end
end
