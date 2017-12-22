class Api::AlertController < ApplicationController

  def staffing_level
    @staffing_level = Event.staffing_level
    render :show
  end
end
