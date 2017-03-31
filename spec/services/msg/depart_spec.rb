require 'rails_helper'

RSpec.describe Msg::Depart do
  
  let!(:person) { create(:person) }
  let!(:phone) { create(:phone, content: "+18005551212", person: person) }
  
  describe "#respond" do
    
    context "with no incomplete timecards" do
      it "should fail to depart" do
        msg = Msg::Depart.new({params: {Body: "depart"}, person: person})
        expect {
          expect(msg.respond).to eq "Error: 0 incomplete timecards."
        }.to change(Timecard, :count).by(1)
      end
    end
    
    context "with incomplete timecard" do
      let!(:timecard) do
        Timecard.create!(person_id: person.id,
                        status: "Incomplete",
                        start_time: Time.now)
      end
      
      it "should complete the timecard" do
        msg = Msg::Depart.new({params: {Body: "depart"}, person: person})
        expect {
          expect(msg.respond).to eq "Timecard completed."
        }.to change(Timecard, :count).by(0)
        expect(timecard.reload.status).to eq("Unverified")
      end
      
      context "2nd incomplete timecard" do
        let!(:timecard2) do
          Timecard.create!(person_id: person.id,
                          status: "Incomplete",
                          start_time: Time.now)
        end
        it "should fail to depart" do
          msg = Msg::Depart.new({params: {Body: "depart"}, person: person})
          expect {
            expect(msg.respond).to eq "Error: 2 incomplete timecards."
          }.to change(Timecard, :count).by(1)
          expect(timecard.reload.status).to eq("Error")
        end
      end
      
    end
    
  end
end
