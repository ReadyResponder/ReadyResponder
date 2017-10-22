require 'rails_helper'

RSpec.describe Availability, type: :model do
  let(:a_person) { build(:person) }

  describe "creation" do
    it "has a valid factory" do
      @availability = build(:availability, person: a_person)
      expect(@availability).to be_valid
    end
  end

  context 'validations' do
    it { should validate_presence_of(:person) }
    it { should validate_presence_of(:status) }
    it { should validate_presence_of(:start_time) }
    it { should validate_presence_of(:end_time) }

    it "requires end_time to be after start_time" do # chronology
      @availability = build(:availability, person: a_person, start_time: Time.current, end_time: 2.minutes.ago)
      expect(@availability).not_to be_valid
    end
  end

  context 'partially_available?' do
    it 'returns false for full availabilities' do
      start_time = Time.current
      end_time = start_time + 2.minutes
      availability = build(:availability, person: a_person,
                           start_time: start_time, end_time: end_time)

      event = create(:event, status: "Scheduled",
                     start_time: start_time, end_time: end_time)
      expect(availability.partially_available?(event)).to eq(false)
    end

    it 'returns false for full availabilities which extend past event boundaries' do
      start_time = Time.current
      end_time = start_time + 2.minutes
      availability = build(:availability, person: a_person,
                            start_time: start_time, end_time: end_time + 2.minutes)

      event = create(:event, status: "Scheduled",
                      start_time: start_time, end_time: end_time)
      expect(availability.partially_available?(event)).to eq(false)
    end
  end

  context 'cancel_duplicates' do
    it 'sets status for previous availabilities with matching start and end times to Cancelled' do
      start_time = Time.at(0)
      end_time = start_time + 2.minutes
      first_availability = create(:availability, person: a_person,
                                  start_time: start_time, end_time: end_time)
      second_availability = create(:availability, person: a_person,
                                   start_time: start_time, end_time: end_time)

      first_availability = first_availability.reload
      expect(first_availability.status).to eq('Cancelled')
      expect(second_availability.status).to eq('Unavailable')
    end
  end

  context 'overlapping_time scope' do
    it 'returns a chainable relation' do
      expect(described_class.overlapping_time([0,1])).to be_a_kind_of(ActiveRecord::Relation)
    end

    context 'given 3 separate availabilities' do
      let!(:first_availability)  { create(:availability, person: a_person,
                                   start_time: 5.hours.ago, end_time: 3.hours.ago) }
      let!(:second_availability) { create(:availability, person: a_person,
                                   start_time: 3.hours.ago, end_time: 1.hour.ago) }

      it 'returns both if the given range covers part of each' do
        date_range = 4.hours.ago..2.hours.ago
        expect(described_class.overlapping_time(date_range)).to contain_exactly(
          first_availability, second_availability)
      end

      it 'returns just one of them if the given range does not cover
      part of the other one' do
        date_range = 6.hours.ago..4.hours.ago
        expect(described_class.overlapping_time(date_range)).to contain_exactly(
          first_availability)
      end
    end
  end
end
