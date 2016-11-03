class AnalyticsController < ApplicationController
  def calendar_chart
    data = Availability.process_data
    respond_to do |format|
      format.json { render json: data }
      format.html
    end
  end
end
