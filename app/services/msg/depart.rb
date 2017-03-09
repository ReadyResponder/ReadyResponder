class Msg::Depart < Msg::Base
  
  def respond
    
    Timecard.transaction do
      incomplete_timecards = @person.timecards.where(status: "Incomplete")
      
      # If the number of incomplete timecards is not exactly 1, create an error 
      # entry so that they can be manually reconciled
      if @person.timecards.where(status: "Incomplete").count != 1
        # set all incomplete timecards to error state
        incomplete_timecards.update_all(status: "Error")
        # record the depart time as a new timecard entry
        Timecard.create!(person: @person,
                         status: "Error",
                         end_time: Time.now)
        return nil
      end
      
      timecard = incomplete_timecards.first
      timecard.update(status: "Unverified", end_time: Time.now)
      return timecard
    end
  end
end
