class EventsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  def schedule
    @event = Event.find(params[:id])
    @person = Person.find(params[:person_id])
    if @person and @event.ready_to_schedule?(params[:card_action])
      @tc = @event.schedule(@person, params[:card_action])
    end

    redirect_to event_url(@event), status: :found, notice: @tc ? "Timecard created" : "Timecard not created"
  end

  # GET /events
  # GET /events.json
  def index
    @events = Event.all
    @page_title = "All Events"
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @events }
    end
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @event = Event.find(params[:id])
    @page_title = @event.title
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @event }
      format.xlsx { render layout: false }
    end
  end

  # GET /events/new
  # GET /events/new.json
  def new
    @event = Event.new
    @page_title = "New Event"
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @event }
    end
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
    @page_title = "Event: #{@event.title}"
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(params[:event])

    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render json: @event, status: :created, location: @event }
      else
        format.html { render action: "new" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /events/1
  # PUT /events/1.json
  def update
    @event = Event.find(params[:id])
    respond_to do |format|
      if @event.update_attributes(params[:event])
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event = Event.find(params[:id])
    @event.destroy

    respond_to do |format|
      format.html { redirect_to events_url }
      format.json { head :no_content }
    end
  end
end
