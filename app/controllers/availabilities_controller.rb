class AvailabilitiesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  before_action :set_availability, only: [:show, :edit, :update, :destroy]

  def index
    @availabilities = Availability.all
  end

  def show
    @last_editor = last_editor(@availability)
  end

  def new
    person = Person.find(params[:person_id]) if params.include? "person_id"
    @event = Event.find(params[:event_id]) if params.include? "event_id"
    @event = Event.new if @event.blank?

    @availability = Availability.new(start_time: @event.start_time,
                                     end_time: @event.end_time)
    @availability.person = person if person

    people = Person.active
    people |= [person] if person
    @people_collection = people.sort
  end

  def edit
    set_people
  end

  def create
    @availability = Availability.new(availability_params)
    if @availability.save
      redirect_to @availability, notice: 'Availability was successfully created.'
    else
      set_people
      render :new
    end
  end

  def update
    if @availability.update(availability_params)
      redirect_to @availability, notice: 'Availability was successfully updated.'
    else
      set_availability
      set_people
      render :edit
    end
  end

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

    def set_people
      @people_collection = Person.active

      # Ensure person is included in @people_collection
      @people_collection |= [@availability.person] if @availability.person
      @people_collection = @people_collection.sort
    end
end
