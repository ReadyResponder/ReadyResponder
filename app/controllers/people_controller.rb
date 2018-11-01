class PeopleController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  before_action :manage_people_depts, only: [:applicants, :index]
  before_action :load_all_depts, only: [:inactive, :everybody]

  before_action :set_referrer_path, only: [:new, :edit]
  before_action :set_return_path, only: [:show]

  def signin
    #This is the sign-in sheet, not anything about authentication
    @department = Department.where(shortname: "BAUX").first
    @people = @department.people.active if @department
    @page_title = "Sign-in"
    render :layout => "print_signin"
  end

  def everybody
    @people = Person.all
    @page_title = "Everybody"
  end

  def applicants
    @people = Person.applicants + Person.prospects
    @page_title = "Applicants"
  end

  def inactive
    @people = Person.inactive + Person.declined
    @page_title = "Inactive People"
  end

  def index
    @people = Person.active.joins(:department).accessible_by(current_ability) +
              Person.leave.joins(:department).accessible_by(current_ability)
    @page_title = "All Active People"
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @people }
    end
  end

  def show
    @person = Person.includes(:comments).find(params[:id])
    @page_title = @person.fullname
    @phones = @person.phones
    vcard = Vcard::Generator.call(@person)
    @qr = RQRCode::QRCode.new(vcard.to_s, level: :q)
    @last_editor = last_editor(@person)
    @comment = Comment.new
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
    # Set default department if there is only one active department
    departments = Department.active.managing_people
    if departments.count == 1
      @person.department = departments.first
    end

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
        format.html { render :edit, alert: @person.errors.full_messages }
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

  def manage_people_depts
    @available_departments = Department.active.where(manage_people: true)
  end

  def load_all_depts
    @available_departments = Department.all
  end

  def person_params
    params.require(:person).permit(
      :firstname, :lastname, :status, :icsid, :department_id,
      :city, :state, :zipcode, :start_date, :end_date,
      :application_date, :title, :gender, :portrait, :date_of_birth,
      :division1, :division2, :title_order, :old_comments, :nickname,
      :channels_attributes => [],
      :title_ids => [],
      phones_attributes: [:id, :category, :content, :name, :status,
                          :usage, :carrier, :sms_available,
                          :priority, :channel_type, :_destroy],
      emails_attributes: [:id, :category, :content, :name, :status, :usage, :_destroy]
    )
  end
end
