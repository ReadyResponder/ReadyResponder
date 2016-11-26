class Msg::Unavailable < Msg::Base
  def respond
    case @params[:Body].split[1].downcase
    when "custom"
      begin
        # available custom 1/15/2017 0800 01/15/2021 Work
        start_time = Time.zone.parse(@params[:Body].split[2..3].join " ")
        end_time = Time.zone.parse(@params[:Body].split[4..5].join " ")
      rescue StandardError => error
        return "Error! Sample => unavailable custom 2016-11-23 00:01 2017-12-31 17:00 Leave of absense <= #{error}"
      end
      target = Event.new(start_time: start_time, end_time: end_time)
      description = @params[:Body].split[6..42].join(" ") if @params[:Body].split.size > 6
    else
      target = Event.find_by_code(@params[:Body].split[1].downcase)
      return target if target.is_a? Error::Base
      description = @params[:Body].split[2]
    end

    # target = Notification.find_by_code(@params[:Body].split[1])
    # TODO Need to verify and save Availabilites as needed.
    Availability.create(person: @person,
                        status: "Unavailable",
                        description: description,
                        start_time: target.start_time,
                        end_time: target.end_time)
  end
end
