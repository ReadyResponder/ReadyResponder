class Msg::Unavailable < Msg::Base
  def respond
    case event_codename
    when "custom"
      # unavailable custom 1/15/2017 0800 01/15/2021 Work
      unless start_time.is_a? Time and end_time.is_a? Time
        return "Error! Sample => unavailable custom 2016-11-23 00:01 2017-12-31 17:00 Leave of absense <="
      end

      target = Event.new(start_time: start_time, end_time: end_time)
      description = body_words[6..-1].join(" ") if body_size > 6
    else
      target = Event.find_by_code(event_codename)
      return target if target.is_a? Error::Base
      description = body_words[2..-1].join(' ')
    end

    # target = Notification::find_by_code.call(event_codename)
    # TODO Need to verify and save Availabilites as needed.

    availability_creator = AvailabilityCreator.new(person: @person,
      status: 'Unavailable', description: description, start_time: target.start_time,
      end_time: target.end_time)

    if availability_creator.call
      availability_creator.availability
    else
      availability_creator.errors.full_messages
    end
  end

  private

  def start_time
    return nil unless event_codename and body_size > 5
    @start_time ||= Time.zone.parse body_words[2..3].join(' ')
  end

  def end_time
    return nil unless event_codename and body_size > 5
    @end_time ||= Time.zone.parse body_words[4..5].join(' ')
  end
end
