require 'rails_helper'

RSpec.describe Event do
  describe 'associations' do
    it 'has many notifications' do
      expect(subject).to have_many(:notifications)
    end
  end

  it { should validate_presence_of(:status) }
  it { should validate_presence_of(:id_code) }

  it "has a valid factory" do
    expect(create(:event)).to be_valid
  end

  it "is invalid without a title" do
    expect(build(:event, title: nil)).not_to be_valid
  end

  it "is invalid if end_time is before start_time" do # chronology
    expect(build(:event, start_time: Time.current, end_time: 10.days.ago)).not_to be_valid
  end

  it "is invalid if start_time is blank and status is completed" do
    expect(build(:event, status: "Completed", start_time: nil, end_time: 10.days.ago )).not_to be_valid
  end

  it "is invalid if end_time is blank and status is completed" do
    expect(build(:event, status: "Completed", start_time: Time.current, end_time: nil)).not_to be_valid
  end

  it "changes the id_code to lower case and trims it" do
    @event = create(:event, id_code: " HowDy DOOdy ")
    expect(@event.id_code).to eq("howdy")
  end

  context "finds the correct events as concurrent" do
    it "doesn't find an old event" do
      @old_event = create(:event, id_code: "old", start_time: Time.at(111), end_time: Time.at(222))
      expect(Event.concurrent(Time.at(550)..Time.at(650))).not_to include(@old_event)
    end
    it "doesn't find an future event" do
      @future_event = create(:event, id_code: "future", start_time: Time.at(888), end_time: Time.at(999))
      expect(Event.concurrent(Time.at(550)..Time.at(650))).not_to include(@future_event)
    end
    it "finds an event that overlaps the start" do
      @overlap_start = create(:event, id_code: "starting", start_time: Time.at(500), end_time: Time.at(600))
      expect(Event.concurrent(Time.at(550)..Time.at(650))).to include(@overlap_start)
    end
    it "finds an event that overlaps the end" do
      @overlap_end = create(:event, id_code: "ending", start_time: Time.at(600), end_time: Time.at(777))
      expect(Event.concurrent(Time.at(550)..Time.at(650))).to include(@overlap_end)
    end
    it "finds an event that's shorter than the given range" do
      @short_event = create(:event, id_code: "short", start_time: Time.at(590), end_time: Time.at(610))
      expect(Event.concurrent(Time.at(550)..Time.at(650))).to include(@short_event)
    end
    it "finds an event that's longer than the given range" do
      @long_event = create(:event, id_code: "long", start_time: Time.at(333), end_time: Time.at(888))
      expect(Event.concurrent(Time.at(550)..Time.at(650))).to include(@long_event)
    end
  end
  it "counts as upcoming if it hasnt ended" do
    @event = create(:event, start_time: Time.current, end_time: 75.minutes.from_now, status: "Scheduled")
    expect(Event.upcoming.include?(@event)).to be(true)
  end

end
