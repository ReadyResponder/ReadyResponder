require 'rails_helper'

RSpec.describe Person do
  let!(:person) { create(:person) }
  let!(:phone) { create(:phone, content: "8005551212", person: person) }

  it 'finds the person with the number' do
    expect(Person::FindByChannel.new("+18005551212").call).to eq(person)
  end

  it 'does not find the person with the wrong number' do
    expect(Person::FindByChannel.new("+18008881212").call).to eq(nil)
  end
end
