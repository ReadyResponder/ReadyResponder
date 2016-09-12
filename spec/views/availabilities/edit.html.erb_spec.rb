require 'rails_helper'

RSpec.describe "availabilities/edit", type: :view do
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

  it "renders the edit availability form" do
    render

    assert_select "form[action=?][method=?]", availability_path(@availability), "post" do

      assert_select "select#availability_status[name=?]", "availability[status]"

      assert_select "textarea#availability_description[name=?]", "availability[description]"
    end
  end
end
