class PeopleController < ApplicationController
  before_filter :authenticate_user!
  before_filter :set_return_path
  load_and_authorize_resource

  def signin
    #This is the sign-in sheet, not anything about authentication
    @people = Person.active.all
    @page_title = "Sign-in"
    render :layout => "print_signin"
  end

  def orgchart
    @people = Person.police.active.all
    @page_title = "Org Chart"
    render :layout => "orgchart"
  end

  def police
    @people = Person.police.active.all
    @page_title = "Police"
    render :template => "people/index"
  end
  def everybody
    @people = Person.all
    @page_title = "Everybody"
    render :template => "people/index"
  end
  def cert
    @people = Person.cert.active.all
    @page_title = "CERT"
    render :template => "people/index"
  end

  def other
    @people = Person.active.where(department: 'Other')
    @page_title = "Other Active People"
    render :template => "people/index"
  end

  def applicants
    @people = Person.applicants.all
    @page_title = "Applicants"
  end

  def prospects
    @people = Person.prospects.all
    @page_title = "Prospects"
  end

  def declined
    @people = Person.declined.all
    @page_title = "Declined"
    render :template => "people/index"
  end

  def leave
    @people = Person.leave.all
    @page_title = "People On-Leave"
    render :template => "people/index"
  end

  def inactive
    @people = Person.inactive.all
    @page_title = "Inactive People"
    render :template => "people/index"
  end

  def index
    @people = Person.active.where(department: ['Police', 'CERT'])
    @page_title = "Active Police and CERT"
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @people }
    end
  end

  def show
    @person = Person.find(params[:id])
    @page_title = @person.fullname
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @person }
    end
  end

  def new
    @page_title = "New Person"
    @person = Person.new(status: cookies[:status], state: 'MA')
    @person.channels.build
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @person }
    end
  end

  def edit
    @person = Person.find(params[:id])
    @person.channels.build if @person.channels(true).empty?
  end

  def create
    @person = Person.new(params[:person])
    cookies[:status] = params[:person][:status]
    respond_to do |format|
      if @person.save
        format.html { redirect_to session[:return_to], notice: 'Person was successfully created.' }
        format.json { render json: @person, status: :created, location: @person }
      else
        format.html { render action: "new" }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @person = Person.find(params[:id])
    if @person.update_attributes(params[:person])
      flash.notice = 'Person was successfully updated.'
      redirect_to person_path(@person)
    else
      render :action => 'edit'
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

  def set_return_path
    session[:return_to] ||= request.referer
  end
end
