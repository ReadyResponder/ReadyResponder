require 'rails_helper'

RSpec.describe Msg::Available do
  let(:args) { { person: person,
                 params: { Body: "available #{event_code}" } } }

  let(:person)     { build(:person) }
  let(:event_code) { 'event_123' }

  subject { described_class.new(args) }

  describe 'respond' do
    context 'when passed a non-existent event code' do
      before(:example) do
        error = build(:error_base)
        allow(Event).to receive(:find_by_code).with(event_code) { error }
      end

      it 'returns an instance of Error::Base' do
        expect(subject.respond).to be_an(Error::Base)
      end
    end

    context 'when passed an existing event code' do
      before(:example) do
        @event = build(:event)
        allow(Event).to receive(:find_by_code).with(event_code) { @event }
      end
      
      it 'creates an availability' do
        expect(subject.respond).to be_an(Availability)
      end

      describe 'the created availability' do
        let(:availability) { subject.respond }
        
        it 'has the start_time equal to that of the matched event' do
          expect(availability.start_time).to eq(@event.start_time)
        end  
        
        it 'has the end_time equal to that of the matched event' do
          expect(availability.end_time).to eq(@event.end_time)
        end  
      end
    end

    context 'when passed the "custom" keyword with 2 timestamps' do
      let(:event_code) { "custom #{start_time} #{end_time}" }

      context 'with 2 valid timestamps' do
        let(:start_time) { 1.hour.ago.strftime('%Y-%m-%d %H:%M') }
        let(:end_time)   { 1.hour.from_now.strftime('%Y-%m-%d %H:%M') }
      
        it 'creates an availability' do
          expect(subject.respond).to be_an(Availability)
        end

        describe 'the created availability' do
          let(:availability) { subject.respond }
        
          it 'has the start_time equal to that of the matched event' do
            result = availability.start_time.strftime '%Y-%m-%d %H:%M'
            expect(result).to eq(start_time)
          end  
        
          it 'has the end_time equal to that of the matched event' do
            result = availability.end_time.strftime '%Y-%m-%d %H:%M'
            expect(result).to eq(end_time)
          end  
        end
      end

      context 'with invalid timestamps' do
        let(:start_time) { 'not' }
        let(:end_time)   { nil }

        it 'returns an error message when at least one of the timezones cannot be
        parsed' do
          expect(subject.respond).to match(/^Error! Sample =>/)
        end
      end
    end
  end
end
