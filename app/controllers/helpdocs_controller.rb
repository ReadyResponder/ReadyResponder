class HelpdocsController < ApplicationController
  # GET /helpdocs
  # GET /helpdocs.json
  def index
    @helpdocs = Helpdoc.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @helpdocs }
    end
  end

  # GET /helpdocs/1
  # GET /helpdocs/1.json
  def show
    @helpdoc = Helpdoc.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @helpdoc }
    end
  end

  # GET /helpdocs/new
  # GET /helpdocs/new.json
  def new
    @helpdoc = Helpdoc.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @helpdoc }
    end
  end

  # GET /helpdocs/1/edit
  def edit
    @helpdoc = Helpdoc.find(params[:id])
  end

  # POST /helpdocs
  # POST /helpdocs.json
  def create
    @helpdoc = Helpdoc.new(params[:helpdoc])

    respond_to do |format|
      if @helpdoc.save
        format.html { redirect_to @helpdoc, notice: 'Helpdoc was successfully created.' }
        format.json { render json: @helpdoc, status: :created, location: @helpdoc }
      else
        format.html { render action: "new" }
        format.json { render json: @helpdoc.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /helpdocs/1
  # PUT /helpdocs/1.json
  def update
    @helpdoc = Helpdoc.find(params[:id])

    respond_to do |format|
      if @helpdoc.update_attributes(params[:helpdoc])
        format.html { redirect_to @helpdoc, notice: 'Helpdoc was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @helpdoc.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /helpdocs/1
  # DELETE /helpdocs/1.json
  def destroy
    @helpdoc = Helpdoc.find(params[:id])
    @helpdoc.destroy

    respond_to do |format|
      format.html { redirect_to helpdocs_url }
      format.json { head :no_content }
    end
  end
end
