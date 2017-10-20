require 'rqrcode'
module QrCode
  class Generator
    attr_reader :person, :vcard
    def self.call(person)
      new(person).call
    end

    def initialize(person)
      @person = person
    end

    def call
      vcard = Vcard::Generator.call(person)
      RQRCode::QRCode.new( vcard.to_s, :level => :q ).as_html
    end
  end
end
