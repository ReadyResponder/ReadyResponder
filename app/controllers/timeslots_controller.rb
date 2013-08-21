class TimeslotsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  
  def index
    @timeslots = Timeslot.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @timeslots }
    end
  end

  def show
    @timeslot = Timeslot.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @timeslot }
    end
  end

  def new
    @timeslot = Timeslot.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @timeslot }
    end
  end

  def edit
    @timeslot = Timeslot.find(params[:id])
  end

  def create
    @timeslot = Timeslot.new(params[:timeslot])

    respond_to do |format|
      if @timeslot.save
        format.html { redirect_to @timeslot, notice: 'Timeslot was successfully created.' }
        format.json { render json: @timeslot, status: :created, location: @timeslot }
      else
        format.html { render action: "new" }
        format.json { render json: @timeslot.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @timeslot = Timeslot.find(params[:id])

    respond_to do |format|
      if @timeslot.update_attributes(params[:timeslot])
        format.html { redirect_to @timeslot, notice: 'Timeslot was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @timeslot.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @timeslot = Timeslot.find(params[:id])
    @timeslot.destroy

    respond_to do |format|
      format.html { redirect_to Timeslots_url }
      format.json { head :no_content }
    end
  end
end
