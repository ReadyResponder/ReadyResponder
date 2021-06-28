class Api::AlertController < ApplicationController

  def staffing_level
    @staffing_level = StaffingLevel.staffing_level
    render :show
  end
end
