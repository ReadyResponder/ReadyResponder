class TimecardsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  
  def index
    @timecards = Timecard.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @timecards }
    end
  end

  def show
    @timecard = Timecard.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @timecard }
    end
  end

  def new
    @timecard = Timecard.new
    #Seems like I should be able to use Timecard.new(params[:timecard]), but they're not nested
    if params[:event_id]  
      @event = Event.find(params[:event_id])
      @timecard.person_id = params[:person_id]
      @timecard.event_id = params[:event_id]
      if params[:intention]
        @timecard.intention = params[:intention]
        @timecard.intended_start_time = @event.start_time
        @timecard.intended_end_time = @event.end_time
      end
      if params[:outcome]
        @timecard.outcome = params[:outcome]
        @timecard.actual_start_time = @event.start_time
        @timecard.actual_end_time = @event.end_time
      end
      @timecard.category = @event.category
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @timecard }
    end
  end

  def edit
    @timecard = Timecard.find(params[:id])
  end

  def create
    @timecard = Timecard.new(params[:timecard])

    respond_to do |format|
      if @timecard.save
        format.html { redirect_to @timecard, notice: 'Timecard was successfully created.' }
        format.json { render json: @timecard, status: :created, location: @timecard }
      else
        format.html { render action: "new" }
        format.json { render json: @timecard.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @timecard = Timecard.find(params[:id])

    @timecard.intention = (params[:intention]) if params[:intention]
    @timecard.outcome = (params[:outcome]) if params[:outcome]
    respond_to do |format|
      if @timecard.update_attributes(params[:timecard])
        @event = @timecard.event
        format.html { redirect_to event_url(@event) }
        #redirect_to event_url(@event), status: :found, notice: "Timecard created"
        #redirect_to event_url(@event), status: :found, notice: "Timecard updated"
        #format.html { redirect_to @timecard, notice: 'Timecard was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @timecard.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @timecard = Timecard.find(params[:id])
    @event = @timecard.event
    @timecard.destroy

    respond_to do |format|
      format.html { redirect_to event_url(@event) }
      format.json { head :no_content }
    end
  end
end
