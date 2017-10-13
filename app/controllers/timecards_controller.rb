class TimecardsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource

  def index
    @timecards = Timecard.all.order(start_time: :desc)
  end

  def show
    @last_editor = last_editor(@timecard)
  end

  def new
    set_referrer_path
    event = Event.find params[:event] if params.has_key? :event
    @timecard = Timecard.new
    @timecard.start_time = event.start_time if event
    @timecard.end_time = event.end_time if event
    @timecard.person_id = params[:person_id] if params.has_key? :person_id
    @timecard.status = "Verified"
  end

  def edit
    set_referrer_path
  end

  def create
    @timecard = Timecard.new(params[:timecard])

    if @timecard.save
      redirect_to referrer_or(@timecard), notice: 'Timecard was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    if @timecard.update_attributes(params[:timecard])
      redirect_to referrer_or(timecards_path), notice: 'Timecard was successfully updated.'
    else
      render action: "edit"
    end
  end

  def verify
    if @timecard.status == 'Unverified'
      @timecard.status = 'Verified'
      if @timecard.save
        respond_to do |format|
          format.html {
            redirect_to request.referrer || timecards_path
          }
          format.json {
            render json: @timecard
          }
        end
      end
    else
      respond_to do |format|
        format.html {
          redirect_to request.referrer || timecards_path, notice: 'Timecard is not in an unverified status'
        }
        format.json {
          render json: { notice: 'Timecard is not in an unverified status' }
        }
      end
    end
  end

  def destroy
    @timecard.destroy
    redirect_to timecards_path
  end
end
