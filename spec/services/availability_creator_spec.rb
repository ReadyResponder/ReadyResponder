require 'rails_helper'

RSpec.describe AvailabilityCreator do
  let(:person) { create(:person) }
  let(:status) { 'Available' }
  let(:availability_params) { attributes_for(:availability, status: status,
    start_time: 6.hours.ago, end_time: 6.hours.from_now).merge({ person: person }) }

  before(:example) do
    Timecop.freeze
  end

  after(:example) do
    Timecop.return
  end
  
  subject { described_class.new availability_params }

  it 'creates an availability' do
    expect { subject.call }.to change { Availability.count }.by 1
  end

  it 'returns a boolean' do
    expect(subject.call).to be(true).or be(false)
  end

  context 'given an existing availability' do
    let!(:previous_availability) { create(:availability, person: person,
      status: old_status, start_time: start_time, end_time: end_time) }

    context 'that contains the new availability' do
      let(:start_time) { availability_params[:start_time] - 3.hours }
      let(:end_time)   { availability_params[:end_time] + 3.hours }

      context 'and has the same status' do
        let(:old_status) { availability_params[:status] }

        it 'does not create a new availability' do
          expect { subject.call }.not_to change { Availability.count }
        end
      end

      context 'and has a different status' do
        let(:old_status) { 'Unavailable' }

        it 'creates 2 new availabilities' do
          expect { subject.call }.to change { Availability.count }.by 2
        end

        it 'makes the resulting 3 availabilities contiguous' do
          subject.call
          availabilities = Availability.all.order(:start_time)

          expect(availabilities[0].end_time).to eq(availabilities[1].start_time)
          expect(availabilities[1].end_time).to eq(availabilities[2].start_time)
        end
      end
    end

    context 'that is contained by the new availability' do
      let(:start_time) { availability_params[:start_time] + 3.hours }
      let(:end_time)   { availability_params[:end_time] - 3.hours }
      let(:old_status) { availability_params[:status] }

      it 'creates a new availability' do
        expect { subject.call }.to change { Availability.count }.by 1
      end

      it 'cancels the previous availability' do
        expect { subject.call }.to change { 
          previous_availability.reload.status }.from('Available').to('Cancelled')
      end
    end

    context 'that partially overlaps the new availability' do
      let(:start_time) { availability_params[:start_time] - 2.hours }
      let(:end_time)   { availability_params[:start_time] + 1.hour }

      context 'and has the same status' do
        let(:old_status) { availability_params[:status] }

        it 'creates a new availability' do
          expect { subject.call }.to change { Availability.count }.by 1
        end

        it 'cancels the previous availability' do
          expect { subject.call }.to change { 
            previous_availability.reload.status }.from('Available').to('Cancelled')
        end

        it 'adjusts the new availability\'s start/end_time so that it includes the previous\''do
          subject.call
          new_availability = Availability.last

          expect(new_availability.start_time).to be_within(1.second).of(previous_availability.start_time)
        end
      end
    end
  end
end
