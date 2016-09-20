require 'rails_helper'

RSpec.describe "availabilities/index", type: :view do
  before(:each) do
    @cj = create(:person, firstname: 'CJ', lastname: 'Doe' )
    assign(:availabilities, [
      Availability.create!(
        :person => @cj,
        :status => "Unavailable",
        :description => "Vacation",
        :start_time => "2016-09-11 17:00",
        :end_time => "2016-09-11 18:00"
      ),
      Availability.create!(
      :person => @cj,
      :status => "Available",
      :description => "Pick Me !",
      :start_time => "2016-09-11 17:00",
      :end_time => "2016-09-11 18:00"
      )
    ])
  end

  it "renders a list of availabilities" do
    render
    assert_select "tr>td", :text => "Available".to_s, :count => 1
    assert_select "tr>td", :text => "CJ Doe".to_s, :count => 2
  end
end
