class VendorsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  
  def index
    @vendors = Vendor.all
  end

  def show
    @vendor = Vendor.find(params[:id])
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

  private

  def vendor_params
    params.require(:vendor).permit(:name, :street, :city, :state, :zipcode, :status, :comments)
  end
end
