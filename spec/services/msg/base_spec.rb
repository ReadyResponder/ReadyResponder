require 'rails_helper'

RSpec.describe Msg::Base do
  describe 'initialization' do
    let(:message) { Msg::Base.new({person: person, params: {Body: body}}) }

    context 'given a message body parameter' do
      let(:person) { nil }
      let(:body)   { 'some text from the sender' }
    
      it 'returns the text in the body attribute' do
        expect(message.body).to eq(body)
      end

      it 'returns the total words in the message body' do
        expect(message.body_words).to include('some', 'text')
      end

      it 'returns the total number of words in the message body' do
        expect(message.body_size).to eq(5)
      end
    end

    context 'given no message body parameter' do
      let(:person) { nil }
      let(:body)   { nil }

      it 'returns nil in the body attribute' do
        expect(message.body).to be_nil
      end

      it 'returns 0 as the total words' do
        expect(message.body_size).to be_zero
      end
    end
  end

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
