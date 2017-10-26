require 'rqrcode'
module QrCode
  class Generator
    attr_reader :text
    def self.call(text)
      new(text).call
    end

    def initialize(text)
      @text = text
    end

    def call
      RQRCode::QRCode.new(text, level: :q ).as_html
    end
  end
end
