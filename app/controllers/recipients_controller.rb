class RecipientsController < ApplicationController
  before_action :set_recipient, only: [:show, :edit, :update, :destroy]

  # GET /recipients
  def index
    @recipients = Recipient.all
  end

  # GET /recipients/1
  def show
  end

  # GET /recipients/new
  def new
    @recipient = Recipient.new
  end

  # GET /recipients/1/edit
  def edit
  end

  # POST /recipients
  def create
    @recipient = Recipient.new(recipient_params)

    if @recipient.save
      redirect_to @recipient, notice: 'Recipient was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /recipients/1
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
    # Use callbacks to share common setup or constraints between actions.
    def set_recipient
      @recipient = Recipient.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def recipient_params
      params[:recipient]
    end
end
