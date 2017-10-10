require 'rails_helper'

RSpec.describe Timecard do
  before(:context) do
    @cj = create(:person, firstname: 'CJ')
  end
  
  describe 'associations' do
    it { should belong_to(:person) }
  end

  describe "creation" do
    it "has a valid factory" do
      timecard = build(:timecard, person: @cj)
      expect(timecard).to be_valid
    end

    it { should validate_presence_of(:person) }

    it "requires end_time to be after start_time" do # chronology
      timecard = build(:timecard, person: @cj, start_time: Time.current, end_time: 2.minutes.ago)
      expect(timecard).not_to be_valid
    end

    it "calculates an duration" do
      @timecard = create(:timecard,  person: @cj, start_time: Time.current, end_time: Time.current)
      expect(@timecard.duration).to eq(0)
      @timecard = create(:timecard,  person: @cj, start_time: Time.current, end_time: 75.minutes.from_now)
      expect(@timecard.duration).to eq(1.25)
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

  describe 'scopes' do
    context 'given a Verified timecard and another one with a different status, the verified scope' do
      before(:example) do
        @verified_timecard = create(:timecard, person: @cj, status: 'Verified')
        @another_timecard = create(:timecard, person: @cj, status: 'another')
      end
      
      it 'returns a chainable relation' do
        expect(described_class.verified).to be_a_kind_of(ActiveRecord::Relation)
      end

      it 'returns a collection with Verified timecards' do
        expect(described_class.verified).to contain_exactly(@verified_timecard)
      end

      it 'returns a collection that has no unverified timecards' do
        expect(described_class.verified).not_to include(@another_timecard)
      end
    end

    context 'given 3 timecards with unordered start_time, the most_recent scope' do
      before(:example) do
        @last_timecard   = create(:timecard, person: @cj, start_time: Time.now, end_time: 1.second.from_now)
        @first_timecard  = create(:timecard, person: @cj, start_time: 2.hours.ago, end_time: 1.second.from_now)
        @middle_timecard = create(:timecard, person: @cj, start_time: 1.hour.ago, end_time: 1.second.from_now)
      end

      it 'returns a chainable relation' do
        expect(described_class.most_recent).to be_a_kind_of(ActiveRecord::Relation)
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
end
