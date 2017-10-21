require 'rails_helper'

RSpec.describe 'receiving an availability message', type: :request do
  let!(:phone)  { create(:phone, content: '+11234567890') }
  let!(:person) { phone.person }
  let(:msg)     { { From: phone.content, Body: body } }
  class MessageSender
    Message = Struct.new(:From, :To, :Body)
    
    def self.send_availability_with(body)
      msg = Message.new '+11234567890', 'the_app',
        body

    end
  end

  context 'with an existing event id' do
    let(:event)  { create(:event, id_code: 'code01') }
    let(:body)   { "available #{event.id_code}" }

    it 'creates an availability for the sender' do
      expect { post '/texts/receive_text', msg }.to change { 
        person.availabilities.count }.by 1
    end

    it 'sets the new availability\'s start_time to the one of the event' do
      post '/texts/receive_text', msg
      availability = person.availabilities.last
      expect(availability.start_time).to be_within(1.second).of(event.start_time)
    end

    it 'sets the new availability\'s end_time to the one of the event' do
      post '/texts/receive_text', msg
      availability = person.availabilities.last
      expect(availability.end_time).to be_within(1.second).of(event.end_time)
    end
  end
end
