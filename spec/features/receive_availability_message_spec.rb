require 'rails_helper'

RSpec.describe 'receiving an availability message', type: :request do
  let!(:phone)  { create(:phone, content: '+11234567890') }
  let!(:person) { phone.person }
  let(:msg)     { { From: phone.content, Body: body } }

  before(:example) do
    Timecop.freeze
  end

  after(:example) do
    Timecop.return
  end

  context 'with the available keyword' do
    let(:availability_type) { 'available' }

    context 'and an existing event id' do
      let(:event)  { create(:event, id_code: 'code01', start_time: 1.hour.from_now,
                            end_time: 23.hours.from_now) }
      let(:body)   { "#{availability_type} #{event.id_code}" }

      it 'creates an availability for the sender' do
        expect { post '/texts/receive_text', msg }.to change { 
          person.availabilities.count }.by 1
      end

      it 'sets the availability\'s status as Available' do
        post '/texts/receive_text', msg
        availability = person.availabilities.last
        expect(availability.status).to eq('Available')
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

      it 'returns a plain text response with information about the new availability' do
        post '/texts/receive_text', msg
        expect(response.content_type).to eq(:text)
        expect(response.body).to match(
          /^Recorded Available[\s\S]+start[\s\S]+end[\s\S]+description/)
      end

      context 'given an existing availability that has the same status and is contained by the new one' do
        let!(:previous_availability) { create(:availability, person: person,
                                              status: 'Available', start_time: 2.hours.from_now, end_time: 4.hours.from_now) }

        it 'cancels that person\'s existing availability ' do
          expect { post '/texts/receive_text', msg }.to change { 
            previous_availability.reload.status }.from('Available').to('Cancelled')
        end
      end

      context 'given an existing availability has the same status and contains the new one' do
        let!(:previous_availability) { create(:availability, person: person,
          status: 'Available', start_time: event.start_time - 2.hours,
          end_time: event.end_time + 2.hours) }

        it 'does not create a new availability' do
          expect { post '/texts/receive_text', msg }.not_to change { Availability.count }
        end

        it 'returns an error message' do
          post '/texts/receive_text', msg
          expect(response.body).to match(/Error![\s\S]+/)
        end
      end

      context 'given an existing availability that does not have the same status and contains the new one' do
        let!(:previous_availability) { create(:availability, person: person,
          status: 'Unavailable', start_time: event.start_time - 2.hours,
          end_time: event.end_time + 2.hours) }

        it 'splits a person\'s existing availability into 2 while creating the new one' do
          expect { post '/texts/receive_text', msg }.to change { 
            person.availabilities.count }.by 2
        end

        it 'splits a person\'s existing availability so that the first one ends at the new availability\'s start_time' do
          post '/texts/receive_text', msg
          
          availabilities = person.availabilities.where(status: 'Unavailable').order(:start_time)

          expect(availabilities[0].end_time).to be_within(1.second).of(event.start_time)
        end

        it 'splits a person\'s existing availability so that the last one starts at the new availability\'s end_time' do
          post '/texts/receive_text', msg

          availabilities = person.availabilities.where(status: 'Unavailable').order(:start_time)

          expect(availabilities[1].start_time).to be_within(1.second).of(event.end_time)
        end
      end
    end

    context 'and a non-existent event id' do
      let(:event_code) { 'fake01' }
      let(:body)       { "#{availability_type} #{event_code}" }

      it 'does not create a new availability' do
        expect { post '/texts/receive_text', msg }.not_to change { 
          person.availabilities.count }
      end

      it 'returns a plain text response with an error informing the user that the event does not exist' do
        post '/texts/receive_text', msg
        expect(response.content_type).to eq(:text)
        expect(response.body).to eq("(201) Event #{event_code} not found")
      end
    end

    context 'and the custom keyword' do
      let(:body) { "#{availability_type} custom #{start_time} #{end_time}" }
      
      context 'with no start_time and/or end_time' do
        let(:start_time) { '123 123' }
        let(:end_time)   { nil }

        it 'returns a plain text response with an error and a sample' do
          post '/texts/receive_text', msg
          expect(response.body).to match(/\AError! Sample.*$/)
        end
      end

      context 'with a start_time and end_time' do
        let(:start_time) { 30.minutes.from_now.strftime('%Y-%m-%d %H:%M') }
        let(:end_time)   { 1.hour.from_now.strftime('%Y-%m-%d %H:%M') }

        it 'creates an availability for the sender' do
          expect { post '/texts/receive_text', msg }.to change { 
            person.availabilities.count }.by 1
        end

        it 'sets the availability\'s status as Available' do
          post '/texts/receive_text', msg
          availability = person.availabilities.last
          expect(availability.status).to eq('Available')
        end

        it 'sets the new availability\'s start_time to the one of the event' do
          post '/texts/receive_text', msg
          availability = person.availabilities.last
          result = availability.start_time.strftime '%Y-%m-%d %H:%M'
          expect(result).to eq(start_time)
        end

        it 'sets the new availability\'s end_time to the one of the event' do
          post '/texts/receive_text', msg
          availability = person.availabilities.last
          result = availability.end_time.strftime '%Y-%m-%d %H:%M'
          expect(result).to eq(end_time)
        end

        it 'returns a plain text response with information about the new availability' do
          post '/texts/receive_text', msg
          expect(response.content_type).to eq(:text)
          expect(response.body).to match(
            /^Recorded Available[\s\S]+start[\s\S]+end[\s\S]+description/)
        end

        context 'given an existing availability that has the same status and is contained by the new one' do
          let!(:previous_availability) { create(:availability, person: person,
            status: 'Available', start_time: 30.minutes.ago, end_time: 30.minutes.from_now) }

          it 'cancels that person\'s existing availability ' do
            expect { post '/texts/receive_text', msg }.to change { 
              previous_availability.reload.status }.from('Available').to('Cancelled')
          end
        end
      end
    end
  end

  context 'with the unavailable keyword' do
    let(:availability_type) { 'unavailable' }

    context 'and an existing event id' do
      let(:event)  { create(:event, id_code: 'code01') }
      let(:body)   { "#{availability_type} #{event.id_code}" }

      it 'sets the availability\'s status as Unavailable' do
        post '/texts/receive_text', msg
        availability = person.availabilities.last
        expect(availability.status).to eq('Unavailable')
      end
    end
  end
end
