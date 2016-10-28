require 'rails_helper'

RSpec.describe TimeRoundingService do

  describe "#closest_fifteen" do

    context "given an event" do
      it "removes milliseconds from start_time" do
        @event = build(:event)
        @rounded_event = TimeRoundingService.new(@event).closest_fifteen
        expect(@rounded_event.start_time.strftime("%L")).to eq("000")
      end

      it "removes seconds from start_time" do
        @event = build(:event)
        @rounded_event = TimeRoundingService.new(@event).closest_fifteen
        expect(@rounded_event.start_time.strftime("%S")).to eq("00")
      end

      it "removes milliseconds from end_time" do
        @event = build(:event)
        @rounded_event = TimeRoundingService.new(@event).closest_fifteen
        expect(@rounded_event.end_time.strftime("%L")).to eq("000")
      end

      it "removes seconds from end_time" do
        @event = build(:event)
        @rounded_event = TimeRoundingService.new(@event).closest_fifteen
        expect(@rounded_event.end_time.strftime("%S")).to eq("00")
      end

      it "rounds start time to closest quarter hour after given time" do
        @event = build(:event)
        @event.start_time = @event.start_time.change(:min => 14)
        @rounded_event = TimeRoundingService.new(@event).closest_fifteen
        expect(@rounded_event.start_time.strftime("%M")).to eq("15")
      end

      it "rounds start time to closest quarter hour after given time" do
        @event = build(:event)
        @event.start_time = @event.start_time.change(:min => 2)
        @rounded_event = TimeRoundingService.new(@event).closest_fifteen
        expect(@rounded_event.start_time.strftime("%M")).to eq("15")
      end

      it "rounds end time to closest quarter hour before given time" do
        @event = build(:event)
        @event.end_time = @event.end_time.change(:min => 14)
        @rounded_event = TimeRoundingService.new(@event).closest_fifteen
        expect(@rounded_event.end_time.strftime("%M")).to eq("00")
      end

      it "rounds end time to closest quarter hour before given time" do
        @event = build(:event)
        @event.end_time = @event.end_time.change(:min => 2)
        @rounded_event = TimeRoundingService.new(@event).closest_fifteen
        expect(@rounded_event.end_time.strftime("%M")).to eq("00")
      end
    end

  end

end
