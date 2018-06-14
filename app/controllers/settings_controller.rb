class SettingsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  before_action :set_setting, only: [:show, :edit, :update, :destroy]

  # GET /settings
  def index
    @settings = Setting.all
    @page_title = "Settings"
  end

  # GET /settings/1
  def show
  end

  # GET /settings/new
  def new
    @setting = Setting.new
  end

  # GET /settings/1/edit
  def edit
  end

  # POST /settings
  def create
    @setting = Setting.new(setting_params)

    if @setting.save
      redirect_to @setting, notice: 'Setting was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /settings/1
  def update
    if @setting.update(setting_params)
      redirect_to @setting, notice: 'Setting was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /settings/1
  def destroy
    @setting.destroy
    redirect_to settings_url, notice: 'Setting was successfully destroyed.'
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_setting
    @setting = Setting.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def setting_params
    params.require(:setting).permit(:name, :description, :key, :value, :category, :status, :required)
  end
end
