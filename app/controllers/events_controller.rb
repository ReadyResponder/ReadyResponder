class EventsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  def index
    # by default show all scheduled or in-session events
    @events = params['all_events'] == "true" ? Event.all : Event.where('end_time > ?', Time.now)
    @page_title = params['all_events'] == "true" ? "All Events" : "Current Events"
  end

  def show
    @event = Event.find(params[:id])
    @page_title = @event.title
  end

  def new
    @event = Event.new
    @page_title = "New Event"
  end

  def edit
    @event = Event.find(params[:id])
    @page_title = "Event: #{@event.title}"
  end

  def create
    @event = Event.new(params[:event])
    if @event.save
      redirect_to @event, notice: 'Event was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    @event = Event.find(params[:id])
    if @event.update_attributes(params[:event])
      redirect_to @event, notice: 'Event was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to events_url
  end
end
