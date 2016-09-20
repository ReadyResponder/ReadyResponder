require 'rails_helper'

RSpec.describe "availabilities/show", type: :view do
  before(:each) do
    @cj = create(:person, firstname: 'CJ', lastname: 'Doe' )
    @availability = assign(:availability, Availability.create!(
      :status => "Available",
      :person => @cj,
      :description => "Howdy",
      :start_time => 3.hours.ago,
      :end_time => 1.hours.ago
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Available/)
    expect(rendered).to match(/Howdy/)
  end
end
