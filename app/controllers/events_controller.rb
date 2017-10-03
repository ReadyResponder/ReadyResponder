class EventsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    # by default show all scheduled or in-session events
    @events = params['all_events'] == "true" ? Event.all : Event.actual.where('end_time > ?', Time.now)
    @page_title = params['all_events'] == "true" ? "All Events" : "Current Events"
  end

  def show
    @page_title = @event.title
    @last_editor = last_editor(@event)
  end

  def new
    @event = Event.new
    @page_title = "New Event"
  end

  def edit
    @page_title = "Event: #{@event.title}"
  end

  def create
    @event = Event.new(event_params)
    @event.use_a_template if @event.template.present?

    if @event.save
      redirect_to @event, notice: 'Event was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    if @event.update_attributes(event_params)
      redirect_to @event, notice: 'Event was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @event.destroy
    redirect_to events_path
  end

  private
  def event_params
    params.require(:event).permit(:title, :description, :category,
    :course_id, :duration, :start_time, :end_time, :instructor, :location,
    :id_code, :status, :timecard_ids, :person_ids, :comments,
    :is_template, :template_id, department_ids: [])
  end
end
