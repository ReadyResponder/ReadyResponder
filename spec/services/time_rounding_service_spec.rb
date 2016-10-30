require 'rails_helper'

RSpec.describe TimeRoundingService do

  describe "#closest_fifteen" do

  let(:event){ build_stubbed(:event) }

    context "given an event" do

      it "rounds times in the first quarter of an hour correctly" do
        event.start_time = event.start_time.change(:hour => 9, :min => 1,
                                                     :sec => 35, :usec => 231)
        event.end_time = event.end_time.change(:hour => 9, :min => 14,
                                                     :sec => 35, :usec => 231)

        @rounded_event = TimeRoundingService.new(event).closest_fifteen

        expect(@rounded_event.start_time.strftime("%H:%M:%S:%L")).to eq("09:15:00:000")
        expect(@rounded_event.end_time.strftime("%H:%M:%S:%L")).to eq("09:00:00:000")
      end

    end

  end

end
