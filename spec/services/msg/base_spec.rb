require 'rails_helper'

RSpec.describe Msg::Base do
  describe "extracting event codename" do
    it "should extract it when present" do
      base_msg = Msg::Base.new({params: {Body: "foo\ncodename"}})
      expect(base_msg.get_event_codename).to eq("codename")
    end
    it "should downcase the event codename" do
      base_msg = Msg::Base.new({params: {Body: "foo\nCoDenaMe"}})
      expect(base_msg.get_event_codename).to eq("codename")
    end
    
    it "should return nil when not present" do
      base_msg = Msg::Base.new({params: {}})
      expect(base_msg.get_event_codename).to eq(nil)
      base_msg = Msg::Base.new({params: {Body: nil}})
      expect(base_msg.get_event_codename).to eq(nil)
    end
  end
end
