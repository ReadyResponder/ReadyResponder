class RepairsController < ApplicationController
  # GET /repairs
  # GET /repairs.json
  def index
    @repairs = Repair.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @repairs }
    end
  end

  # GET /repairs/1
  # GET /repairs/1.json
  def show
    @repair = Repair.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @repair }
    end
  end

  # GET /repairs/new
  # GET /repairs/new.json
  def new
    @repair = Repair.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @repair }
    end
  end

  # GET /repairs/1/edit
  def edit
    @repair = Repair.find(params[:id])
  end

  # POST /repairs
  # POST /repairs.json
  def create
    @repair = Repair.new(params[:repair])

    respond_to do |format|
      if @repair.save
        format.html { redirect_to @repair, notice: 'Repair was successfully created.' }
        format.json { render json: @repair, status: :created, location: @repair }
      else
        format.html { render action: "new" }
        format.json { render json: @repair.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /repairs/1
  # PUT /repairs/1.json
  def update
    @repair = Repair.find(params[:id])

    respond_to do |format|
      if @repair.update_attributes(params[:repair])
        format.html { redirect_to @repair, notice: 'Repair was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @repair.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /repairs/1
  # DELETE /repairs/1.json
  def destroy
    @repair = Repair.find(params[:id])
    @repair.destroy

    respond_to do |format|
      format.html { redirect_to repairs_url }
      format.json { head :no_content }
    end
  end
end
