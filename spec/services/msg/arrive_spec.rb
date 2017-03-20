require 'rails_helper'

RSpec.describe Msg::Arrive do
  
  let!(:person) { create(:person) }
  let!(:phone) { create(:phone, content: "+18005551212", person: person) }
  
  describe "#respond" do
    
    context "with no incomplete timecards" do
      it "should start the timecard" do
        msg = Msg::Arrive.new({params: {Body: "arrive"}, person: person})
        expect {
          expect(msg.respond).to eq "Timecard started."
        }.to change(Timecard, :count).by(1)
      end
    end
    
    context "with an existing incomplete timecard" do
      before(:each) do
        Timecard.create!(person_id: person.id,
                        status: "Incomplete",
                        start_time: Time.now)
      end
      
      it "should not start a new timecard" do
        msg = Msg::Arrive.new({params: {Body: "arrive"}, person: person})
        expect {
          expect(msg.respond).to eq "Error: incomplete timecard exists."
        }.to change(Timecard, :count).by(0)
      end
    end
    
  end
end
