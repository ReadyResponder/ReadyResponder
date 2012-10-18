class InspectionsController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @inspections = Inspection.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @inspections }
    end
  end

  # GET /inspections/1
  # GET /inspections/1.json
  def show
    @inspection = Inspection.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @inspection }
    end
  end

  # GET /inspections/new
  # GET /inspections/new.json
  def new
    @inspection = Inspection.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @inspection }
    end
  end

  # GET /inspections/1/edit
  def edit
    @inspection = Inspection.find(params[:id])
  end

  # POST /inspections
  # POST /inspections.json
  def create
    @inspection = Inspection.new(params[:inspection])

    respond_to do |format|
      if @inspection.save
        format.html { redirect_to @inspection, notice: 'Inspection was successfully created.' }
        format.json { render json: @inspection, status: :created, location: @inspection }
      else
        format.html { render action: "new" }
        format.json { render json: @inspection.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /inspections/1
  # PUT /inspections/1.json
  def update
    @inspection = Inspection.find(params[:id])

    respond_to do |format|
      if @inspection.update_attributes(params[:inspection])
        format.html { redirect_to @inspection, notice: 'Inspection was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @inspection.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /inspections/1
  # DELETE /inspections/1.json
  def destroy
    @inspection = Inspection.find(params[:id])
    @inspection.destroy

    respond_to do |format|
      format.html { redirect_to inspections_url }
      format.json { head :no_content }
    end
  end
end
