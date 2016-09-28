require 'rails_helper'

RSpec.describe Task, type: :model do
  let(:an_event) { create(:event) }
  it "has a valid factory" do
    expect(create(:task)).to be_valid
    expect(create(:task, event: an_event)).to be_valid
  end

  context 'validations' do
    it { should validate_presence_of(:event) }
    it { should validate_presence_of(:title) }
    it { should validate_presence_of(:start_time) }
    it { should validate_presence_of(:end_time) }

    it "requires end_time to be after start_time" do #chronology
      @task = build(:task, event: an_event, start_time: Time.current, end_time: 2.minutes.ago)
      expect(@task).not_to be_valid
    end

    context 'chronology validations' do #chronology
      let(:start_t)     { 2.days.from_now }
      let(:end_t)       { 4.days.from_now }
      let(:bad_start_t) { 6.days.from_now }
      let(:bad_end_t)   { 0.days.from_now }
      let(:a_task)      { create(:task, event: an_event, title: "a task",
                                             start_time: start_t, end_time: end_t) }

      before(:each) do
        a_task.start_time = start_t
        a_task.end_time = end_t
      end

      it "should reject chronologies where start is after end" do
        expect(a_task).to_not allow_value(bad_start_t).for(:start_time)
      end

      it "should reject chronologies where end is before start" do
        expect(a_task).to_not allow_value(bad_end_t).for(:end_time)
      end

      it "should accept times that are in chronological order" do
        expect(a_task).to allow_value(start_t).for(:start_time)
        expect(a_task).to allow_value(end_t).for(:end_time)
      end
    end
  end
end
