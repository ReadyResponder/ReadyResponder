require 'rails_helper'
require 'support/request_helper'

RSpec.describe "GET events/:id", type: :request do
  describe "Availablities table shows correct availablities" do
    before(:each) do
      login_as_editor

      @event_start_time = 2.hours.from_now
      @event_end_time = 12.hours.from_now
      @event = create(:event, start_time: @event_start_time, end_time: @event_end_time)

      @two_hours_before_event_start = @event_start_time - 2.hours
      @two_hours_after_event_start = @event_start_time + 2.hours
      @two_hours_before_event_end = @event_end_time - 2.hours
      @two_hours_after_event_end = @event_end_time + 2.hours
    end

    context "when the availablites are partially available" do
      it "returns availabilities that start before the event and end during the event" do
        availability = create(:availability, start_time: @two_hours_before_event_start, end_time: @two_hours_after_event_start)

        get "/events/#{@event.id}"

        expect(response.body).to include(availability.person.name)
      end

      it "returns availablities that start during the event and end during the event" do
        availability = create(:availability, start_time: @two_hours_after_event_start, end_time: @two_hours_before_event_end)

        get "/events/#{@event.id}"

        expect(response.body).to include(availability.person.name)
      end

      it "returns availablities that start during the event and end after the event" do
        availability = create(:availability, start_time: @two_hours_after_event_start, end_time: @two_hours_after_event_end)

        get "/events/#{@event.id}"

        expect(response.body).to include(availability.person.name)
      end
    end

    context "when the availablities are fully available" do
      it "returns availablites that start before the event and end after the event" do
        availability = create(:availability, start_time: @two_hours_before_event_start, end_time: @two_hours_after_event_end)

        get "/events/#{@event.id}"

        expect(response.body).to include(availability.person.name)
      end

      it "returns availablities that start and end at the same times as the event" do
        availability = create(:availability, start_time: @event_start_time, end_time: @event_end_time)

        get "/events/#{@event.id}"

        expect(response.body).to include(availability.person.name)
      end
    end

    context "when the availablities are not available" do
      it "does not return availablities that end before the event" do
        availability = create(:availability, start_time: @two_hours_before_event_start - 1.hour, end_time: @two_hours_before_event_start)

        get "/events/#{@event.id}"

        expect(response.body).to_not include(availability.person.name)
      end

      it "does not return availablities that start after the event" do
        availability = create(:availability, start_time: @two_hours_after_event_end, end_time: @two_hours_after_event_end + 1.hour)

        get "/events/#{@event.id}"

        expect(response.body).to_not include(availability.person.name)
      end
    end
  end
end