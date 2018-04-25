class CertsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @certs = Cert.all
  end

  def show
    @last_editor = last_editor(@cert)
  end

 def new
    @cert.person_id = (params[:person_id]) if (params[:person_id]).present?
  end

  def edit
  end

  def create
    @cert = Cert.new(cert_params)
    if @cert.save
      redirect_to person_path(@cert.person), notice: 'Cert was successfully created.'
    else
      render action: "new"
    end
  end

  def update
    if @cert.update_attributes(cert_params)
      redirect_to @cert, notice: 'Cert was successfully updated.'
    else
      render action: "edit"
    end
  end

  def destroy
    @cert.destroy
    redirect_to certs_url
  end

  private

  def cert_params
    params.require(:cert).permit(:category, :person_id, :course_id, :expiration_date, :issued_date, :cert_number, :level,  :status, :certification, :comments)
  end
end
