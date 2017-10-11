require 'rails_helper'

RSpec.describe Timecard do
  before(:context) do
    @cj = create(:person, firstname: 'CJ')
  end
  
  describe 'associations' do
    it { should belong_to(:person) }
  end

  describe 'validation' do
    it { should validate_presence_of(:person) }

    it "requires end_time to be after start_time" do # chronology
      timecard = build(:timecard, person: @cj, start_time: Time.current, end_time: 2.minutes.ago)
      expect(timecard).not_to be_valid
    end
  end

  describe "creation" do
    it "has a valid factory" do
      timecard = build(:timecard, person: @cj)
      expect(timecard).to be_valid
    end

    it "finds the existing timecard if it's a duplicate",
      skip: "Find duplicate timecards is too simple, but not needed until people are scanning in" do
      @person = create(:person)
      @original_timecard = create(:timecard,  person: @person,
                                              intended_start_time: 42.minutes.from_now,
                                              intended_end_time: 8.hours.from_now,
                                              intention: "Available")
      @duplicate_timecard = build(:timecard,  person: @person,
                                              intended_start_time: 42.minutes.from_now,
                                              intended_end_time: 8.hours.from_now,
                                              intention: "Available")
      expect(@duplicate_timecard.find_duplicate_timecards.size).to eq(1)
      @duplicate_timecard = build(:timecard, event: @event, person: @person, actual_start_time: 42.minutes.from_now, outcome: "Worked")
      expect(@duplicate_timecard.find_duplicate_timecards.size).to eq(1)
    end
  end

  describe 'self.overlapping_time' do
    it 'returns all timecards that overlap a date range (start..end)' do
      past_timecard = create(:timecard, person: @cj, start_time: 2.days.ago, end_time: 1.day.ago)
      future_timecard = create(:timecard, person: @cj, start_time: 2.days.from_now, end_time: 3.days.from_now)
      in_between_event_timecard = create(:timecard, person: @cj, start_time: Time.current, end_time: 60.minutes.from_now)
      overlapping_timecard = create(:timecard, person: @cj, start_time: 2.days.ago, end_time: 3.days.from_now)
      event = create(:event)
      event_timecards = Timecard.overlapping_time(event.start_time..event.end_time)
      expect(event_timecards).to include(in_between_event_timecard)
      expect(event_timecards).to include(overlapping_timecard)
      expect(event_timecards).not_to include(past_timecard)
      expect(event_timecards).not_to include(future_timecard)
    end
  end


  describe 'verified scope' do
    it 'returns a chainable relation' do
      expect(described_class.verified).to be_a_kind_of(ActiveRecord::Relation)
    end

    context 'given a Verified timecard and another one with a different status' do
      before(:example) do
        @verified_timecard = create(:timecard, person: @cj, status: 'Verified')
        @another_timecard = create(:timecard, person: @cj, status: 'another')
      end

      it 'returns a collection with Verified timecards' do
        expect(described_class.verified).to contain_exactly(@verified_timecard)
      end
    end
  end

  describe 'most_recent scope' do
    it 'returns a chainable relation' do
      expect(described_class.most_recent).to be_a_kind_of(ActiveRecord::Relation)
    end

    context 'given 3 timecards with unordered start_time' do
      before(:example) do
        @last_timecard   = create(:timecard, person: @cj, start_time: Time.current, end_time: 1.second.from_now)
        @first_timecard  = create(:timecard, person: @cj, start_time: 2.hours.ago, end_time: 1.second.from_now)
        @middle_timecard = create(:timecard, person: @cj, start_time: 1.hour.ago, end_time: 1.second.from_now)
      end

      it 'includes all existing timecards' do
        expect(described_class.most_recent.count).to eq(3)
      end

      it 'returns the most recent timecard as its first element' do
        expect(described_class.most_recent.first).to eq(@first_timecard)
      end

      it 'returns the oldest timecard as its last element' do
        expect(described_class.most_recent.last).to eq(@last_timecard)
      end
    end
  end

  describe 'working scope' do
    it 'returns a chainable relation' do
      expect(described_class.working).to be_a_kind_of(ActiveRecord::Relation)
    end

    context 'given 3 timecards: an Incomplete one with no end_time; another also Incomplete 
             but with an end_time; a generic timecard' do
      before(:example) do
        @working_timecard  = create(:timecard, person: @cj, start_time: Time.current,
                                    end_time: nil, status: 'Incomplete')
        @finished_timecard = create(:timecard, person: @cj, start_time: 1.hour.ago,
                                    end_time: Time.current, status: 'Incomplete')
        @timecard          = create(:timecard, person: @cj)
      end

      it 'returns the timecard with Incomplete status and no end_time' do
        expect(described_class.working).to contain_exactly(@working_timecard)
      end
    end
  end

  describe 'active scope' do
    it 'returns all timecards that are not cancelled' do
      incomplete_timecard = create(:timecard, person: @cj, status: 'Incomplete')
      unverified_timecard = create(:timecard, person: @cj, status: 'Unverified')
      error_timecard = create(:timecard, person: @cj, status: 'Error')
      verified_timecard = create(:timecard, person: @cj, status: 'Verified')
      cancelled_timecard = create(:timecard, person: @cj, status: 'Cancelled')
      active_timecards = Timecard.active
      expect(active_timecards).to include(incomplete_timecard, unverified_timecard, error_timecard, verified_timecard)
      expect(active_timecards).not_to include(cancelled_timecard)
    end
  end

  describe 'duration' do
    let(:timecard) { build(:timecard, person: @cj,
                           start_time: start_time, end_time: end_time) }

    context 'given a start_time and no end_time' do
      let(:start_time) { 30.minutes.ago }
      let(:end_time)   { nil }

      it 'is set to 0 when the timecard is saved' do
        timecard.save
        timecard.reload
        expect(timecard.duration).to eq(0)
      end
    end

    context 'given a start_time and an end_time' do
      let(:start_time) { 1.hour.ago }
      let(:end_time)   { Time.now }

      it 'is set to the time difference (in hours) between both values when the timecard is saved' do
        timecard.save
        timecard.reload
        expect(timecard.duration).to be_within(0.1).of(1.0)
      end
    end
  end
end
