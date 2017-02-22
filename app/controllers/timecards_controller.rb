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
    @timecard = Timecard.new
    @timecard.person_id = params[:person_id]
  end

  def edit
  end

  def create
    @timecard = Timecard.new(params[:timecard])

    if @timecard.save
      redirect_to @timecard, notice: 'Timecard was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    if @timecard.update_attributes(params[:timecard])
      redirect_to timecards_path, notice: 'Timecard was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @timecard.destroy
    redirect_to timecards_path
  end
end
