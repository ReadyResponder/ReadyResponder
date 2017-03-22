class Msg::Depart < Msg::Base
  # @returns String
  def respond
    # this block potentially involves several write operations, which we want 
    # to be atomic.
    Timecard.transaction do
      incomplete_timecards = @person.timecards.where(status: "Incomplete")
      
      timecards_count = @person.timecards.where(status: "Incomplete").count
      if timecards_count == 1
        timecard = incomplete_timecards.first
        timecard.update!(status: "Unverified", end_time: Time.now)
        return "Timecard completed."
      else
        # If the number of incomplete timecards is not exactly 1:
        # set all incomplete timecards to error state...
        incomplete_timecards.update_all(status: "Error")
        # ...then record the depart time as a new timecard entry.
        Timecard.create!(person_id: @person.id,
                         status: "Error",
                         end_time: Time.now)
        return "Error: #{timecards_count} incomplete timecards."
      end
    end
  end
end
