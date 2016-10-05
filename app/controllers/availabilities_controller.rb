class AvailabilitiesController < ApplicationController
  before_action :set_availability, only: [:show, :edit, :update, :destroy]

  # GET /availabilities
  def index
    @availabilities = Availability.all
  end

  # GET /availabilities/1
  def show
  end

  # GET /availabilities/new
  def new
    @person = Person.find(params[:person_id]) if params.include? "person_id"
    @availability = Availability.new
    @availability.person = @person if @person
  end

  # GET /availabilities/1/edit
  def edit
  end

  # POST /availabilities
  def create
    @availability = Availability.new(availability_params)
    if @availability.save
      redirect_to @availability, notice: 'Availability was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /availabilities/1
  def update
    if @availability.update(availability_params)
      redirect_to @availability, notice: 'Availability was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /availabilities/1
  def destroy
    @availability.destroy
    redirect_to availabilities_url, notice: 'Availability was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_availability
      @availability = Availability.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def availability_params
      params.require(:availability).permit(:person_id, :start_time, :end_time, :status, :description)
    end
end
