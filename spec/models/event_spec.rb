require 'rails_helper'

RSpec.describe Event do

  describe 'validations' do
    subject { create(:event) }

    it { is_expected.to validate_presence_of(:category) }
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:status) }
    it { is_expected.to validate_presence_of(:id_code) }
    it { is_expected.to validate_presence_of(:start_time) }
    it { is_expected.to validate_presence_of(:end_time) }
    it { is_expected.to validate_presence_of(:departments) }

    it { is_expected.to validate_uniqueness_of(:title) }
    it { is_expected.to validate_uniqueness_of(:id_code) }

    it "is invalid if end_time is before start_time" do # chronology
      expect(build(:event, start_time: Time.current, end_time: 10.days.ago)).not_to be_valid
    end

    it "is invalid if start_time is blank and status is completed" do
      expect(build(:event, status: "Completed", start_time: nil, end_time: 10.days.ago )).not_to be_valid
    end

    it "is invalid if end_time is blank and status is completed" do
      expect(build(:event, status: "Completed", start_time: Time.current, end_time: nil)).not_to be_valid
    end
  end

  describe 'associations' do
    it { is_expected.to belong_to(:template) }
    it { is_expected.to have_many(:templated_events) }
    it { is_expected.to have_and_belong_to_many(:departments) }
    it { is_expected.to have_many(:certs) }
    it { is_expected.to belong_to(:course) }
    it { is_expected.to have_many(:activities) }
    it { is_expected.to have_many(:tasks) }
    it { is_expected.to have_many(:requirements) }
    it { is_expected.to have_many(:assignments) }
    it { is_expected.to have_many(:people) }
    it { is_expected.to have_many(:notifications) }
  end

  it { is_expected.to accept_nested_attributes_for(:certs) }

  it "has a valid factory" do
    expect(create(:event)).to be_valid
  end

  it "changes the id_code to lower case and trims it" do
    event = create(:event, id_code: " HowDy DOOdy ")
    expect(event.id_code).to eq("howdy")
  end

  it "only sends notifications to above a certain rank" do
    event = create(:event, min_title: "Director")
    user = FactoryBot.create(:person, title: "Recruit")
    expect(event.eligible_people).not_to include(user)
  end

  it "only sends notifications to a certain rank and above officers" do
    event = create(:event, min_title: "Director")
    user = FactoryBot.create(:person, title: "Director")
    expect(event.eligible_people).to include(user)
  end

  context "finds the correct events as concurrent" do
    it "doesn't find an old event" do
      old_event = create(:event, id_code: "old", start_time: Time.at(111), end_time: Time.at(222))
      expect(Event.concurrent(Time.at(550)..Time.at(650))).not_to include(old_event)
    end

    it "doesn't find an future event" do
      future_event = create(:event, id_code: "future", start_time: Time.at(888), end_time: Time.at(999))
      expect(Event.concurrent(Time.at(550)..Time.at(650))).not_to include(future_event)
    end

    it "finds an event that overlaps the start" do
      overlap_start = create(:event, id_code: "starting", start_time: Time.at(500), end_time: Time.at(600))
      expect(Event.concurrent(Time.at(550)..Time.at(650))).to include(overlap_start)
    end

    it "finds an event that overlaps the end" do
      overlap_end = create(:event, id_code: "ending", start_time: Time.at(600), end_time: Time.at(777))
      expect(Event.concurrent(Time.at(550)..Time.at(650))).to include(overlap_end)
    end

    it "finds an event that's shorter than the given range" do
      short_event = create(:event, id_code: "short", start_time: Time.at(590), end_time: Time.at(610))
      expect(Event.concurrent(Time.at(550)..Time.at(650))).to include(short_event)
    end

    it "finds an event that's longer than the given range" do
      long_event = create(:event, id_code: "long", start_time: Time.at(333), end_time: Time.at(888))
      expect(Event.concurrent(Time.at(550)..Time.at(650))).to include(long_event)
    end
  end

  it "counts as upcoming if it hasnt ended" do
    event = create(:event, start_time: Time.current, end_time: 75.minutes.from_now, status: "Scheduled")
    expect(Event.upcoming.include?(event)).to be_truthy
  end

  context 'When has 4 events with different dates' do
    let!(:event_000) { create :event, start_time: 4.days.from_now, end_time: 10.days.from_now }
    let!(:event_001) { create :event, start_time: 2.days.from_now, end_time: 4.days.from_now }
    let!(:event_002) { create :event, start_time: 3.days.from_now, end_time: 7.days.from_now }
    let!(:event_003) { create :event, start_time: 7.days.from_now, end_time: 9.days.from_now }

    describe '#next_event' do
      let(:result) { event_001.next_event }

      it 'should return event_002' do
        expect(result).to eq event_002
      end
    end

    describe '#previous_event' do
      let(:result) { event_003.previous_event }

      it 'should return event_000' do
        expect(result).to eq event_000
      end
    end
  end

  context "responses" do
    let (:start_time){ 1.day.from_now }
    let (:end_time){2.days.from_now }
    let(:people) { create_list(:person, 7) }
    let (:a1){create(:availability, person: people[0],
                 start_time: start_time - 1.hour, end_time: end_time - 1.hour)}
    let (:a2){create(:availability, person: people[1],
                 start_time: start_time + 1.hour, end_time: end_time + 1.hour)}
    let (:a3){create(:availability, person: people[2],
                 start_time: start_time + 1.hour, end_time: end_time - 1.hour)}
    let (:a4){create(:availability, person: people[3],
                 start_time: start_time , end_time: end_time )}
    let (:a5){create(:availability, person: people[4],
                     start_time: start_time - 1.hour, end_time: end_time + 1.hour)}
    let (:a6){create(:availability, person: people[5],
                     start_time: start_time - 2.hour, end_time: start_time - 1.hour)}
    let (:a7){create(:availability, person: people[6],
                     start_time: end_time + 1.hour, end_time: end_time + 2.hour)}

    let(:event){create(:event, status: "Scheduled",
                     start_time: start_time, end_time: end_time)}
    context "full_responses" do
      it "should include responses that are < start_time and > end_time" do
        expect(event.full_responses).to include(a5)
      end
      it "should include responses that are = start_time and = end_time" do
        expect(event.full_responses).to include(a4)

      end
      it "should not include responses that end before end" do
        expect(event.full_responses).not_to include(a1)
        expect(event.full_responses).not_to include(a3)
        expect(event.full_responses).not_to include(a6)
      end
      it "should not include responses that start after start" do
        expect(event.full_responses).not_to include(a2)
        expect(event.full_responses).not_to include(a3)
        expect(event.full_responses).not_to include(a7)
      end
    end
    context "partial_responses" do
      it "should include partial responses that are < start_time and < end time" do
        expect(event.partial_responses).to include(a1)
      end

      it "should include partial responses that are > start time and < end time" do
        expect(event.partial_responses).to include(a3)
      end

      it "should include partial responses that are > start time and > end time" do
        expect(event.partial_responses).to include(a2)
      end

      it "should not include responses that are = start_time and = end_time" do
        expect(event.partial_responses).not_to include(a4)
      end
      it "should not include responses that are < start_time and > end_time" do
        expect(event.partial_responses).not_to include(a5)
      end
      it "should not include responses that are entirely before start_time" do
        expect(event.partial_responses).not_to include(a6)
      end
      it "should not include responses that are entirely after end_time" do
        expect(event.partial_responses).not_to include(a7)
      end
    end

  end
end
