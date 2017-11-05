require 'rails_helper'

RSpec.describe Msg::Available do
  let(:args) { { person: person,
                 params: { Body: "available #{event_code}" } } }

  let(:person)     { build(:person) }
  let(:event_code) { 'event_123' }

  before(:example) do
    Timecop.freeze
  end

  after(:example) do
    Timecop.return
  end

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
      context 'when the start time of the event is in the future' do
        before(:example) do
          @event = build(:event, start_time: 1.hour.from_now)
          allow(Event).to receive(:find_by_code).with(event_code) { @event }
        end
        
        it 'creates an availability' do
          expect(subject.respond).to be_an(Availability)
        end

        describe 'the created availability' do
          let(:availability) { subject.respond }
          
          it 'has the start_time equal to that of the matched event' do
            expect(availability.start_time).to be_within(10.seconds).of(@event.start_time)
          end  
          
          it 'has the end_time equal to that of the matched event' do
            expect(availability.end_time).to eq(@event.end_time)
          end  
        end
      end

      context 'when the start time of the event is in the past' do
        before(:example) do
          @event = build(:event, start_time: 1.hour.ago)
          allow(Event).to receive(:find_by_code).with(event_code) { @event }
        end

        describe 'the created availability' do
          let(:availability) { subject.respond }
          
          it 'has the start_time equal to that of the matched event' do
            expect(availability.start_time).to be_within(1.second).of(Time.zone.now)
          end  
          
          it 'has the end_time equal to that of the matched event' do
            expect(availability.end_time).to eq(@event.end_time)
          end  
        end
      end

      context 'when there is an auto-assignable requirement for the event' do
        let(:requirement) { build :requirement }
        before(:example) do
          @event = build(:event, start_time: 1.hour.from_now)
          allow(Event).to receive(:find_by_code).with(event_code) { @event }
          allow(requirement.assignments).to receive(:create)
          allow(@event).to receive_message_chain('requirements.find_by') { requirement }
        end

        context 'when the requirement is full' do
          before(:example) do
            allow(requirement).to receive(:status) { 'Full' }
          end

          it 'does not create an assignment' do
            subject.respond
            expect(requirement.assignments).not_to have_received :create
          end
        end
        
        context 'when the requirement is not full' do
          before(:example) do 
            allow(requirement).to receive(:status) { 'Not Full' }
          end

          context 'but the person is not qualified' do
            before(:example) do 
              allow(person).to receive(:meets?) { false }
            end

            it 'does not create an assignment' do
              subject.respond
              expect(requirement.assignments).not_to have_received :create
            end
          end

          context 'and the person is qualified' do
            before(:example) do
              allow(person).to receive(:meets?) { true }
            end

            it 'creates an assignment for the requirement' do
              subject.respond
              expect(requirement.assignments).to have_received :create
            end
          end
        end
      end
    end

    context 'when passed the "custom" keyword with 2 timestamps' do
      let(:event_code) { "custom #{entered_start_time} #{end_time}" }

      context 'with 2 valid timestamps' do
        let(:entered_start_time) { 1.hour.ago.strftime('%Y-%m-%d %H:%M') }
        let(:actual_start_time) { Time.zone.now.strftime('%Y-%m-%d %H:%M') }
        let(:end_time)   { 1.hour.from_now.strftime('%Y-%m-%d %H:%M') }
      
        it 'creates an availability' do
          expect(subject.respond).to be_an(Availability)
        end

        describe 'the created availability' do
          let(:availability) { subject.respond }
        
          it 'has the start_time equal to that of the matched event' do
            result = availability.start_time.strftime '%Y-%m-%d %H:%M'
            expect(result).to eq(actual_start_time)
          end  
        
          it 'has the end_time equal to that of the matched event' do
            result = availability.end_time.strftime '%Y-%m-%d %H:%M'
            expect(result).to eq(end_time)
          end  
        end
      end

      context 'with invalid timestamps' do
        let(:entered_start_time) { 'not' }
        let(:end_time)   { nil }

        it 'returns an error message when at least one of the timezones cannot be
        parsed' do
          expect(subject.respond).to match(/^Error! Sample =>/)
        end
      end
    end
  end
end
