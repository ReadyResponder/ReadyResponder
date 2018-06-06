class UniqueIdsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @unique_ids = UniqueId.all
  end

  def show
    @last_editor = last_editor(@assignment)
  end

  def new
    @unique_id = UniqueId.new
  end

  def edit
  end

  def create
    @unique_id = UniqueId.new(unique_id_params)

    if @unique_id.save
      redirect_to @unique_id, notice: 'Unique was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    if @unique_id.update_attributes(unique_id_params)
      redirect_to @unique_id, notice: 'Unique was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @unique_id.destroy
    redirect_to unique_ids_url
  end

  private

    # Use this method to whitelist the permissible parameters. Example:
    # params.require(:person).permit(:name, :age)
    # Also, you can specialize this method with per-user checking of permissible attributes.
  def unique_id_params
    params.require(:unique_id).permit(:category, :item, :status, :value)
  end
end
