require "spec_helper"

describe CertMailer do
  describe "cert_expiring" do
    person = FactoryGirl.create(:person)
    let(:mail) { CertMailer.cert_expiring(person) }

    pending "renders the headers" do
      mail.subject.should eq("Cert expiring")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    pending "renders the body" do
      mail.body.encoded.should match("expiring")
    end
  end

end
