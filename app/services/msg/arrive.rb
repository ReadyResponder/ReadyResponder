class Msg::Arrive < Msg::Base
  # @returns String
  def respond
    # this block potentially involves several write operations, which we want 
    # to be atomic.
    Timecard.transaction do
      # set any incomplete timecards to "Error" before continuing
      incomplete_timecards = @person.timecards.where(status: "Incomplete")
      timecards_count = incomplete_timecards.count
      incomplete_timecards.update_all(status: "Error")
        
      # create a new timecard with a start time of now.
      Timecard.create!(person_id: @person.id,
                      status: "Incomplete",
                      start_time: Time.now)
      
      # we always create a new timecard, but if we set any to error state, let them know.
      response_msg = "Timecard started."
      response_msg += " (Incomplete timecards closed: #{timecards_count})" if timecards_count > 0
      return response_msg
    end
  end
end
