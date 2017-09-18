require 'rails_helper'

RSpec.describe Availability, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"

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
end
