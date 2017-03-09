class Msg::Arrive < Msg::Base
  # @returns [Timecard, nil] - a new timecard if a new one was created, nil 
  # otherwise.
  def respond
    
    # Do not open a new timecard if there are any existing incomplete ones
    return nil if @person.timecards.where(status: "Incomplete").count > 0
    
    # create a new timecard with a start time of now.
    Timecard.create!(person: @person,
                    status: "Incomplete",
                    start_time: Time.now)
  end
end
