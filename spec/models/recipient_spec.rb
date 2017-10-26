require 'rails_helper'

RSpec.describe Recipient, type: :model do
  before do
    allow_any_instance_of(Notification).to \
                receive(:notification_has_at_least_one_recipient).and_return(true)
  end

  it "has a mostly valid factory" do
    expect(create(:recipient)).to be_valid
  end

  describe "#notify!" do
    let(:twilio) { Message::SendNotificationTextMessage.new }
    let(:recipient) { create(:recipient) }

    context "when twilio returns error" do 
      before do
        allow(twilio).to receive(:sms_send) { Twilio::REST::RequestError.new("oops") }
      end

      it "creates message w error status" do
        recipient.notify! twilio
        expect(recipient.messages.first.status).to eq("error")
      end

      it "persists error in message body" do
        recipient.notify! twilio
        expect(recipient.messages.first.body).to eq("oops")
      end
    end

    context "when twilio call succeeds" do
      before do
        allow(twilio).to receive(:sms_send) { instance_double("Twilio::Response", status: "sent", body: "success") }
      end

      it "creates message w sent status" do 
        recipient.notify! twilio
        expect(recipient.messages.first.status).to eq("sent")
      end

      it "persists response in message body" do 
        recipient.notify! twilio
        expect(recipient.messages.first.body).to eq("success")
      end
    end
  end

end
