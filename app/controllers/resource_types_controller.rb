class ResourceTypesController < ApplicationController
  # GET /resource_types
  # GET /resource_types.json
  def index
    @resource_types = ResourceType.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @resource_types }
    end
  end

  # GET /resource_types/1
  # GET /resource_types/1.json
  def show
    @resource_type = ResourceType.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @resource_type }
    end
  end

  # GET /resource_types/new
  # GET /resource_types/new.json
  def new
    @resource_type = ResourceType.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @resource_type }
    end
  end

  # GET /resource_types/1/edit
  def edit
    @resource_type = ResourceType.find(params[:id])
  end

  # POST /resource_types
  # POST /resource_types.json
  def create
    @resource_type = ResourceType.new(resource_type_params)

    respond_to do |format|
      if @resource_type.save
        format.html { redirect_to @resource_type, notice: 'Resource type was successfully created.' }
        format.json { render json: @resource_type, status: :created, location: @resource_type }
      else
        format.html { render action: "new" }
        format.json { render json: @resource_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /resource_types/1
  # PATCH/PUT /resource_types/1.json
  def update
    @resource_type = ResourceType.find(params[:id])

    respond_to do |format|
      if @resource_type.update_attributes(resource_type_params)
        format.html { redirect_to @resource_type, notice: 'Resource type was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @resource_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /resource_types/1
  # DELETE /resource_types/1.json
  def destroy
    @resource_type = ResourceType.find(params[:id])
    @resource_type.destroy

    respond_to do |format|
      format.html { redirect_to resource_types_url }
      format.json { head :no_content }
    end
  end

  private

    # Use this method to whitelist the permissible parameters. Example:
    # params.require(:person).permit(:name, :age)
    # Also, you can specialize this method with per-user checking of permissible attributes.
    def resource_type_params
      params.require(:resource_type).permit(:description, :fema_code, :fema_kind, :name, :status)
    end
end
