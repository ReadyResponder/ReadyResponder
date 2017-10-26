class RecipientsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  def index
    @recipients = Recipient.all
  end

  def show
  end

  def new
    @recipient = Recipient.new
  end

  def edit
  end

  def create
    @recipient = Recipient.new(recipient_params)

    if @recipient.save
      redirect_to @recipient, notice: 'Recipient was successfully created.'
    else
      render :new
    end
  end

  def update
    if @recipient.update(recipient_params)
      redirect_to @recipient, notice: 'Recipient was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /recipients/1
  def destroy
    @recipient.destroy
    redirect_to recipients_url, notice: 'Recipient was successfully destroyed.'
  end

  private

    # Only allow a trusted parameter "white list" through.
    def recipient_params
      params.require(:recipient).permit(:notification_id, :person_id, :status, :response_channel,
        :response_time)
    end
end
