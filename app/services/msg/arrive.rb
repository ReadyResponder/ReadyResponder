class Msg::Arrive < Msg::Base
  # @returns String
  def respond
    
    # Do not open a new timecard if there are any existing incomplete ones
    return "Error: incomplete timecard exists." if @person.timecards.where(status: "Incomplete").count > 0
    
    # create a new timecard with a start time of now.
    Timecard.create!(person_id: @person.id,
                    status: "Incomplete",
                    start_time: Time.now)
    return "Timecard started."
  end
end
