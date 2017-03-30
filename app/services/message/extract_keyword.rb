class Message::ExtractKeyword
  # if we decide we want to use a tag to control keywords,
  # it might look like this:
  # command = split_body.select { |word| word.include? "#" }
  # code = split_body.select { |word| word.include? "@" }

  def initialize(*query_param)
    @query_param = query_param[0]
    @query_param = "Beetlejuice" if @query_param.blank?
    @query_param = @query_param.downcase
  end

  def call
    first_word = @query_param.split[0]
    white_list = {"available"   => "Available",
                  "yes"         => "Available",
                  "unavailable" => "Unavailable",
                  "no"          => "Unavailable",
                  "upcoming"    => "Upcoming",
                  "info"        => "Info",
                  "arrive"      => "Arrive",
                  "depart"      => "Depart",
                  "arrived"     => "Arrive",
                  "departed"    => "Depart",
                  "here"        => "Arrive",
                  "gone"        => "Depart"}
    # TODO Additional keywords => maybe rcv received ack
    # TODO tasks task roster (who's assigned to event)
    # TODO schedule (What I'm scheduled for)
    # TODO onduty on-duty for who's on duty right now. & signin signout
    # TODO "crew id_code" to allow supervisor to see who has responded.
    return white_list[first_word]
  end
end
