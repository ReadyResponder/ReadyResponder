class AnalyticsController < ApplicationController
  def calendar_chart
    data = Availability.process_data
    respond_to do |format|
      format.json { render json: data }
      format.html
    end
  end

  def system_activity_logs
    @page_title = "System Activity Logs"
    @date = filter_date if date_provided?
    @category = params[:category]
    @logs = filtered_logs
  end

  private
    def filtered_logs
      logs = SystemActivityLog.all

      logs = logs.on_date(filter_date) if date_provided?
      logs = logs.for_category(params[:category]) if params[:category].present?
      logs
    end

    def filter_date
      day = params["date"]["day"].to_i
      month = params["date"]["month"].to_i
      year = params["date"]["year"].to_i

      Date.new(year, month, day)
    end

    def date_provided?
      params["date"] &&
        params["date"]["day"].present? &&
          params["date"]["month"].present? &&
            params["date"]["year"].present?
    end
end
