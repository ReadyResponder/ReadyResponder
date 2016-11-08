class TextsController < ApplicationController
#  skip_before_filter  :verify_authenticity_token
#  to your controller. This way all incoming requests to
#  the controller skips the :verify_authenticity_token filter.
# Alternatively
  protect_from_forgery with: :null_session,
    if: Proc.new { |c| c.request.format == 'application/json' }

  def receive_text
    puts params
    cell = Phone.where(content: params[:From][2..12]).first
    sender = cell.person if cell
    render plain: "Unknown" and return if sender.blank?
    response = ""
    body = params[:Body].downcase
    split_body = body.split
    command = split_body.select { |word| word.include? "#" }
    code = split_body.select { |word| word.include? "@" }
    if body.include? "upcoming"
      events = Event.upcoming.limit(5)
      events.each do |event|
        response += event.start_time.to_s + " " if event.start_time.present?
        response += event.title if event.title.present?
        response += " (#{event.id_code.to_s}) " if event.id_code.present?
        response += + "\n"
      end
    elsif body.include?(" yes")
      # TODO we should watch for duplicate event id codes here
      # We should get only one result.
      event = Event.where(id_code: split_body[0]).first
      response += event.title if event.title.present?
      if Availability.create(person_id: sender.id,
                          start_time: event.start_time,
                          end_time: event.end_time,
                          status: "Available")
        response += " recorded Available"
      end
    elsif body.include?(" no")
      # TODO we should watch for duplicate event id codes here
      # We should get only one result.
      event = Event.where(id_code: split_body[0]).first
      response += event.title if event.title.present?
      Availability.create(person_id: sender.id,
                          start_time: event.start_time,
                          end_time: event.end_time,
                          status: "Unavailable")
    else
      response = "Hello, #{sender.fullname}"
      response += command[0] if command.present?
      response += code[0] if code.present?
    end
    render plain: response
  end



  private
=begin
   Parameters: { "To"=>"+19786088448", "ToZip"=>"01862", "ToState"=>"MA",
               "ToCity"=>"BILLERICA", "ToCountry"=>"US",
               "From"=>"+19784088088", "FromCity"=>"BILLERICA",
               "FromState"=>"MA", "FromZip"=>"01862", "FromCountry"=>"US",
     "SmsMessageSid"=>"SMb6fed33f61d06c114be2ab5cd5702aa0",
     "MessageSid"=>   "SMb6fed33f61d06c114be2ab5cd5702aa0",
     "SmsSid"=>       "SMb6fed33f61d06c114be2ab5cd5702aa0",
     "MessagingServiceSid"=>"MG41b04937eadee26cb5fd10ae51d1ae86",
     "AccountSid"=>"AC38b0f9a487dcceaa9efb0cd181b1a4a9",
     "NumMedia"=>"0",   "SmsStatus"=>"received", "Body"=>"Navy yes",
      "NumSegments"=>"1",  "ApiVersion"=>"2010-04-01"}
=end
    def text_params
      params.require(:text).permit(:To, :From, :Body,
        :MessageSid, :MessagingServiceSid, :AccountSid )
    end
end
