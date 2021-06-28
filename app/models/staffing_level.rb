class StaffingLevel
  def self.staffing_level
    new.staffing_level
  end

  def staffing_level
    current_or_next_events
      .map(&:staffing_level)
      .min_by { |staffing| staffing[:staffing_level_number] }
  rescue => e
    build_staffing_level_error(e)
  end

  private

  def build_staffing_level_error(e)
    {
      staffing_level_number: 500,
      staffing_level_name: "Error: #{e}",
      staffing_level_percentage: "NaN"
    }
  end

  def current_or_next_events
    if !current_events.empty?
      current_events
    elsif !next_event.empty?
      next_event
    else
      raise StandardError.new("There are no events to have a staffing level for")
    end
  end

  def current_events
    @current_events ||=
      Event.where("status in (?)", ["Scheduled", "In-session"])
        .where("start_time < ?", Time.now)
        .where("end_time > ?", Time.now)
  end

  def next_event
    @next_event ||=
      [Event.where("status in (?)", ["Scheduled", "In-session"])
        .where("start_time > ?", Time.now)
        .order("start_time ASC")
        .first].compact
  end
end
