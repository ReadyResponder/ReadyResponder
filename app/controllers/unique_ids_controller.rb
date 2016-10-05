class UniqueIdsController < ApplicationController
  # GET /unique_ids
  # GET /unique_ids.json
  def index
    @unique_ids = UniqueId.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @unique_ids }
    end
  end

  # GET /unique_ids/1
  # GET /unique_ids/1.json
  def show
    @unique_id = UniqueId.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @unique_id }
    end
  end

  # GET /unique_ids/new
  # GET /unique_ids/new.json
  def new
    @unique_id = UniqueId.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @unique_id }
    end
  end

  # GET /unique_ids/1/edit
  def edit
    @unique_id = UniqueId.find(params[:id])
  end

  # POST /unique_ids
  # POST /unique_ids.json
  def create
    @unique_id = UniqueId.new(unique_id_params)

    respond_to do |format|
      if @unique_id.save
        format.html { redirect_to @unique_id, notice: 'Unique was successfully created.' }
        format.json { render json: @unique_id, status: :created, location: @unique_id }
      else
        format.html { render action: "new" }
        format.json { render json: @unique_id.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /unique_ids/1
  # PATCH/PUT /unique_ids/1.json
  def update
    @unique_id = UniqueId.find(params[:id])

    respond_to do |format|
      if @unique_id.update_attributes(unique_id_params)
        format.html { redirect_to @unique_id, notice: 'Unique was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @unique_id.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /unique_ids/1
  # DELETE /unique_ids/1.json
  def destroy
    @unique_id = UniqueId.find(params[:id])
    @unique_id.destroy

    respond_to do |format|
      format.html { redirect_to unique_ids_url }
      format.json { head :no_content }
    end
  end

  private

    # Use this method to whitelist the permissible parameters. Example:
    # params.require(:person).permit(:name, :age)
    # Also, you can specialize this method with per-user checking of permissible attributes.
    def unique_id_params
      params.require(:unique_id).permit(:category, :item, :status, :value)
    end
end
