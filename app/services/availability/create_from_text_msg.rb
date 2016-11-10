class Availability::CreateFromTextMsg
  def self.call(params, person, event, status)
    puts "Event #{event.inspect}"
    description = params[:Body].split[2]
    # I chose not to make this a service object because it persists the object.
    availability = Availability.new do |a|
      a.person = person
      a.start_time = event.start_time # if event.start_time
      a.end_time = event.end_time
      a.status = status
      a.description = description
    end
    return availability
  end
end
