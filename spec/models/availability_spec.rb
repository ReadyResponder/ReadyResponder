require 'rails_helper'

RSpec.describe Availability, type: :model do
  let(:a_person) { build(:person) }

  before(:example) do
    Timecop.freeze
  end

  after(:example) do
    Timecop.return
  end

  describe "creation" do
    it "has a valid factory" do
      availability = build(:availability, person: a_person)
      expect(availability).to be_valid
    end
  end

  context 'validation' do
    it { is_expected.to validate_presence_of(:person) }
    it { is_expected.to validate_presence_of(:status) }
    it { is_expected.to validate_presence_of(:start_time) }
    it { is_expected.to validate_presence_of(:end_time) }

    it "requires end_time to be after start_time" do # chronology
      availability = build(:availability, person: a_person, start_time: Time.now, end_time: 2.minutes.ago)
      expect(availability).not_to be_valid
    end

    describe 'the start_time and end_time' do
      let(:availability) { build(:availability, person: a_person,
        start_time: 2.hours.ago, end_time: 2.hours.from_now) }

      it 'must not overlap one of the person\'s active availabilities' do
        create(:availability, person: a_person,
          start_time: 1.hour.ago, end_time: 3.hours.from_now)
        
        expect(availability).not_to be_valid
      end

      it 'can overlap one of the person\'s inactive availabilities' do
        create(:availability, person: a_person,
          status: 'Cancelled', start_time: 1.hour.ago, end_time: 3.hours.from_now)
        
        expect(availability).to be_valid
      end

      it 'can overlap someone else\'s availabilities' do
        someone_else = create(:person)
        create(:availability, person: someone_else,
          start_time: 2.hours.ago, end_time: 3.hours.from_now)
        
        expect(availability).to be_valid
      end
    end
  end

  describe 'cancel! method' do
    let(:availability) { create(:availability, person: a_person, status: 'Available') }

    it 'marks the status of the availability as Cancelled' do
      expect { availability.cancel! }.to change {
        availability.reload.status }.from('Available').to('Cancelled')
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

  context 'overlapping scope' do
    it 'returns a chainable relation' do
      expect(described_class.overlapping([0,1])).to be_a_kind_of(ActiveRecord::Relation)
    end

    context 'given 3 contiguous availabilities' do
      let!(:first_availability)  { create(:availability, person: a_person,
                                   start_time: 5.hours.ago, end_time: 3.hours.ago) }
      let!(:second_availability) { create(:availability, person: a_person,
                                   start_time: 3.hours.ago, end_time: 1.hour.ago) }
      let!(:third_availability)  { create(:availability, person: a_person,
                                   start_time: 1.hour.ago, end_time: 1.hour.from_now) }

      it 'returns the availabilities whose duration is partially covered by the given date_range' do
        date_range = 4.hours.ago..2.hours.ago
        expect(described_class.overlapping(date_range)).to contain_exactly(
          first_availability, second_availability)
      end

      it 'returns none of them if the given range does not cover any of the availabilities' do
        date_range = 7.hours.ago..6.hours.ago
        expect(described_class.overlapping(date_range)).to be_empty
      end

      it 'returns the availabilities matching the date_range' do
        date_range = second_availability.start_time..second_availability.end_time
        expect(described_class.overlapping(date_range)).to contain_exactly(
          second_availability)
      end

      it 'does not return availabilities that are contiguous to the given date_range' do
        date_range = first_availability.end_time..third_availability.start_time
        expect(described_class.overlapping(date_range)).not_to include(
          first_availability, third_availability)
      end
    end
  end

  context 'not_overlapping scope' do
    it 'returns a chainable relation' do
      expect(described_class.not_overlapping([0,1])).to be_a_kind_of(ActiveRecord::Relation)
    end

    context 'given 3 contiguous availabilities' do
      let!(:first_availability)  { create(:availability, person: a_person,
                                   start_time: 5.hours.ago, end_time: 3.hours.ago) }
      let!(:second_availability) { create(:availability, person: a_person,
                                   start_time: 3.hours.ago, end_time: 1.hour.ago) }
      let!(:third_availability)  { create(:availability, person: a_person,
                                   start_time: 1.hour.ago, end_time: 1.hour.from_now) }

      it 'returns the availabilities whose duration does not overlap the given date_range' do
        date_range = 5.hours.ago..2.hours.ago
        expect(described_class.not_overlapping(date_range)).to contain_exactly(
          third_availability)
      end

      it 'returns an availability that begins at the end of the given date_range' do
        date_range = 7.hours.ago..1.hour.ago
        expect(described_class.not_overlapping(date_range)).to contain_exactly(
          third_availability)
      end
    end
  end

  context 'partially_overlapping scope' do
    it 'returns a chainable relation' do
      expect(described_class.partially_overlapping([0,1])).to be_a_kind_of(ActiveRecord::Relation)
    end

    context 'given 3 availabilites that belong to 3 different people' do
      let(:people) { create_list(:person, 3) }
      let!(:first_availability)  { create(:availability, person: people[0],
                                   start_time: 6.hours.ago, end_time: 3.hours.ago) }
      let!(:second_availability) { create(:availability, person: people[1],
                                   start_time: 4.hours.ago, end_time: 1.hour.ago) }
      let!(:third_availability)  { create(:availability, person: people[2],
                                   start_time: 2.hours.ago, end_time: 1.hour.from_now) }

      it 'returns the availabilities that contain a part of the given date_range' do
        date_range = 5.hours.ago..3.hours.ago
        expect(described_class.partially_overlapping(date_range)).to contain_exactly(
          second_availability)
      end
    end
  end
  
  context 'containing scope' do
    it 'returns a chainable relation' do
      expect(described_class.containing([0,1])).to be_a_kind_of(ActiveRecord::Relation)
    end

    context 'given 3 availabilites that belong to 3 different people' do
      let(:people) { create_list(:person, 3) }
      let!(:first_availability)  { create(:availability, person: people[0],
                                   start_time: 6.hours.ago, end_time: 3.hours.ago) }
      let!(:second_availability) { create(:availability, person: people[1],
                                   start_time: 4.hours.ago, end_time: 1.hour.ago) }
      let!(:third_availability)  { create(:availability, person: people[2],
                                   start_time: 2.hours.ago, end_time: 1.hour.from_now) }

      it 'returns the availabilities that contain the given date_range' do
        date_range = 4.hours.ago..3.hours.ago
        expect(described_class.containing(date_range)).to contain_exactly(
          first_availability, second_availability)
      end

      it 'returns the availabilities matching the date_range' do
        date_range = second_availability.start_time..second_availability.end_time
        expect(described_class.containing(date_range)).to contain_exactly(
          second_availability)
      end

      it 'does not return availabilities that are contiguous to the given date_range' do
        date_range = first_availability.end_time..third_availability.start_time
        expect(described_class.containing(date_range)).not_to include(
          first_availability, third_availability)
      end
    end
  end
  
  context 'contained_in scope' do
    it 'returns a chainable relation' do
      expect(described_class.contained_in([0,1])).to be_a_kind_of(ActiveRecord::Relation)
    end

    context 'given 3 availabilites that belong to 3 different people' do
      let(:people) { create_list(:person, 3) }
      let!(:first_availability)  { create(:availability, person: people[0],
                                   start_time: 6.hours.ago, end_time: 3.hours.ago) }
      let!(:second_availability) { create(:availability, person: people[1],
                                   start_time: 4.hours.ago, end_time: 1.hour.ago) }
      let!(:third_availability)  { create(:availability, person: people[2],
                                   start_time: 2.hours.ago, end_time: 1.hour.from_now) }

      it 'returns the availabilities that fully contained by the given date_range' do
        date_range = 7.hours.ago..Time.now
        expect(described_class.contained_in(date_range)).to contain_exactly(
          first_availability, second_availability)
      end

      it 'returns the availabilities matching the date_range' do
        date_range = second_availability.start_time..second_availability.end_time
        expect(described_class.contained_in(date_range)).to contain_exactly(
          second_availability)
      end

      it 'does not return availabilities that are contiguous to the given date_range' do
        date_range = first_availability.end_time..third_availability.start_time
        expect(described_class.contained_in(date_range)).not_to include(
          first_availability, third_availability)
      end
    end
  end
end
