require "spec_helper"

describe CertMailer do
  describe "cert_expiring" do
    person = FactoryGirl.create(:person)
    let(:mail) { CertMailer.cert_expiring(person) }

   skip "renders the headers" do
      expect(mail.subject).to eq("Cert expiring")
      expect(mail.to).to eq(["to@example.org"])
      expect(mail.from).to eq(["from@example.com"])
    end

    skip"renders the body" do
      expect(mail.body.encoded).to match("expiring")
    end
  end

end
