class PeopleController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  
  def signin
    #This is the sign-in sheet, not anything about authentication
    @people = Person.active.all
    @page_title = "Sign-in"
    render :layout => "print_signin"
  end
  def orgchart
    @people = Person.active.all
    @page_title = "Org Chart"
    render :layout => "orgchart"    
  end

  def index
    @people = Person.active.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @people }
    end
  end

  def show
    @person = Person.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @person }
    end
  end

  def new
    @person = Person.new
    @person.channels.build
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @person }
    end
  end

  def edit
    @person = Person.find(params[:id])
    @person.channels << Channel.new
  end

  def create
    @person = Person.new(params[:person])

    respond_to do |format|
      if @person.save
        format.html { redirect_to people_url, notice: 'Person was successfully created.' }
        format.json { render json: @person, status: :created, location: @person }
      else
        format.html { render action: "new" }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @person = Person.find(params[:id])
    
    respond_to do |format|
      if @person.update_attributes(params[:person])
	CertMailer.cert_expiring(@person).deliver
        format.html { redirect_to people_url, notice: 'Person was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @person = Person.find(params[:id])
    @person.destroy

    respond_to do |format|
      format.html { redirect_to people_url }
      format.json { head :no_content }
    end
  end
end
