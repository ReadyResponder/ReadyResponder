require 'rails_helper'

RSpec.describe Message::ExtractKeyword do
  it 'returns the keyword if handed something on the white list' do
    expect(Message::ExtractKeyword.new("Available").call).to eq("Available")
  end
  it 'returns the keyword if handed something on the white list, any case' do
    expect(Message::ExtractKeyword.new("AvAIlAblE").call).to eq("Available")
  end
  it 'returns nil if handed something NOT on the white list' do
    expect(Message::ExtractKeyword.new("Hack").call).to eq(nil)
  end
  it 'returns nil if handed nil' do
    expect(Message::ExtractKeyword.new().call).to eq(nil)
  end
end
