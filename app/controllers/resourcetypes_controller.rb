class ResourcetypesController < ApplicationController
  # GET /resourcetypes
  # GET /resourcetypes.json
  def index
    @resourcetypes = Resourcetype.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @resourcetypes }
    end
  end

  # GET /resourcetypes/1
  # GET /resourcetypes/1.json
  def show
    @resourcetype = Resourcetype.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @resourcetype }
    end
  end

  # GET /resourcetypes/new
  # GET /resourcetypes/new.json
  def new
    @resourcetype = Resourcetype.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @resourcetype }
    end
  end

  # GET /resourcetypes/1/edit
  def edit
    @resourcetype = Resourcetype.find(params[:id])
  end

  # POST /resourcetypes
  # POST /resourcetypes.json
  def create
    @resourcetype = Resourcetype.new(resourcetype_params)

    respond_to do |format|
      if @resourcetype.save
        format.html { redirect_to @resourcetype, notice: 'Resourcetype was successfully created.' }
        format.json { render json: @resourcetype, status: :created, location: @resourcetype }
      else
        format.html { render action: "new" }
        format.json { render json: @resourcetype.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /resourcetypes/1
  # PATCH/PUT /resourcetypes/1.json
  def update
    @resourcetype = Resourcetype.find(params[:id])

    respond_to do |format|
      if @resourcetype.update_attributes(resourcetype_params)
        format.html { redirect_to @resourcetype, notice: 'Resourcetype was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @resourcetype.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /resourcetypes/1
  # DELETE /resourcetypes/1.json
  def destroy
    @resourcetype = Resourcetype.find(params[:id])
    @resourcetype.destroy

    respond_to do |format|
      format.html { redirect_to resourcetypes_url }
      format.json { head :no_content }
    end
  end

  private

    # Use this method to whitelist the permissible parameters. Example:
    # params.require(:person).permit(:name, :age)
    # Also, you can specialize this method with per-user checking of permissible attributes.
    def resourcetype_params
      params.require(:resourcetype).permit(:description, :femacode, :femakind, :name, :status)
    end
end
