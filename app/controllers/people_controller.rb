class PeopleController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  before_action :set_referrer_path, only: [:new, :edit]

  def signin
    #This is the sign-in sheet, not anything about authentication
    @department = Department.where(shortname: "BAUX").first
    @people = @department.people.active if @department
    @page_title = "Sign-in"
    render :layout => "print_signin"
  end

  def orgchart
    @department = Department.where(shortname: "BAUX").first
    @people = @department.people.active if @department
    @page_title = "Org Chart"
    render :layout => "orgchart"
  end

  def department
    dept = Department.find(params[:dept_id])
    # TODO: more gracefully handle department not found
    head 404 and return if dept.nil?

    @people = Person.active.where(department_id: dept.id)
    @page_title = dept.name
    render :template => "people/index"
  end

  def everybody
    @people = Person
    @page_title = "Everybody"
    render :template => "people/index"
  end

  def other
    @people = Person.active.joins(:department).where("departments.manage_people": false)
    @page_title = "Other Active People"
    render :template => "people/index"
  end

  def applicants
    @people = Person.applicants
    @page_title = "Applicants"
  end

  def prospects
    @people = Person.prospects
    @page_title = "Prospects"
  end

  def declined
    @people = Person.declined
    @page_title = "Declined"
    render :template => "people/index"
  end

  def leave
    @people = Person.leave
    @page_title = "People On-Leave"
    render :template => "people/index"
  end

  def inactive
    @people = Person.inactive
    @page_title = "Inactive People"
    render :template => "people/index"
  end

  def index
    @people = Person.active.joins(:department).where("departments.manage_people": true)
    @page_title = "All Active"
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @people }
    end
  end

  def show
    @person = Person.find(params[:id])
    @page_title = @person.fullname
    @phones = @person.phones
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @person }
    end
  end

  def new
    @page_title = "New Person"
    @person = Person.new(status: cookies[:status], state: 'MA')
    @person.emails.build(category: 'E-Mail', status: 'OK', usage: '1-All')
    @person.phones.build(category: "Mobile Phone", status: "OK", usage: "1-All")
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @person }
    end
  end

  def edit
    @person = Person.includes(:phones, :emails).find(params[:id])
    @page_title = @person.fullname
    @emails = @person.emails
    @phone = @person.channels.select {|p| p.phone?}.first
  end

  def create
    @person = Person.new(person_params)
    cookies[:status] = person_params[:status]
    respond_to do |format|
      if @person.save
        format.html {
          redirect_to referrer_or(everybody_people_path), notice: 'Person was successfully created.'
          ## Redirects to the previously-saved referrer, with a fallback destination.
          ## (This assumes that the user who can create a person
          ## is authorized to access everybody_people_path.)
          ## Other reasonable redirect possibilities: @person, or the
          ## display list for @person.department.
          ## See also below in 'update'.
        }
        format.json { render json: @person, status: :created, location: @person }
      else
        format.html { redirect_to new_person_path, alert: @person.errors.full_messages }
        format.json { render json: @person.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @person = Person.find(params[:id])

    respond_to do |format|
      if @person.update_attributes(person_params)
        format.html { redirect_to referrer_or(everybody_people_path), notice: 'Person was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { redirect_to edit_person_path(@person), notice: @person.errors.full_messages }
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

  private

  def set_referrer_path
    session[:referrer] = request.referer
  end

  def referrer_or(fallback_destination)
    session.delete(:referrer) || fallback_destination
  end

  def person_params
    params.require(:person).permit(
      :firstname, :lastname, :status, :icsid, :department_id,
      :city, :state, :zipcode, :start_date, :end_date,
      :application_date, :title, :gender, :portrait, :date_of_birth,
      :division1, :division2, :channels_attributes, :title_ids,
      :title_order, :old_comments,
      :channels_attributes => [],
      :title_ids => [],
      phones_attributes: [:id, :category, :content, :name, :status,
                          :usage, :carrier, :sms_available,
                          :priority, :channel_type],
      emails_attributes: [:id, :category, :content, :name, :status, :usage]
    )
  end
end
