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

    respond_to do |format|
      if @timecard.update_attributes(params[:timecard])
        format.html { redirect_to @timecard, notice: 'Timecard was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @timecard.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @timecard = Timecard.find(params[:id])
    @timecard.destroy

    respond_to do |format|
      format.html { redirect_to Timecards_url }
      format.json { head :no_content }
    end
  end
end
