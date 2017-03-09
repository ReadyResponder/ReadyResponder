require 'rails_helper'

RSpec.describe Person do
  let!(:person) { create(:person) }
  let!(:phone) { create(:phone, content: "+18005551212", person: person) }

  it 'finds the person with the number' do
    expect(Person.find_by_phone("+18005551212")).to eq(person)
  end

  it 'does not find the person with the wrong number' do
    expect(Person.find_by_phone("+18008881212")).to eq(nil)
  end
end
