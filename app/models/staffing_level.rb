class StaffingLevel < ApplicationRecord
  include Loggable

  def staffing_level
    current_or_next_events
      .map(&:staffing_level)
      .min_by { |staffing| staffing[:staffing_level_number] }
  end

  def self.staffing_level

    current_or_next_events
      .map(&:staffing_level)
      .min_by { |staffing| staffing[:staffing_level_number] }

    # new.staffing_level

    rescue => e
      puts e
      {
        staffing_number: 500,
        staffing_level_name: "Error",
        staffing_level_percentage: "NaN"
      }
  end


  def self.current_or_next_events
    current_events = self.current_events
    current_events.empty? ? [self.next_event] : current_events
  end

  def self.current_events
    Event
      .where("status in (?)", ["Scheduled", "In-session"])
      .where("start_time < ?", Time.now)
      .where("end_time > ?", Time.now)
  end

  def self.next_event
    next_event =
      Event.where("status in (?)", ["Scheduled", "In-session"])
        .where("start_time > ?", Time.now)
        .order("start_time ASC")
        .first
    if !next_event
      next_event = Event.new
    end
    # raise '---Error: There are no events---' unless next_event
    next_event
  end
end
