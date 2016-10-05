require 'rails_helper'

RSpec.describe "availabilities/new", type: :view do
  before(:each) do
    assign(:availability, Availability.new(
      :status => "Available",
      :description => "Howdy",
      :start_time => 3.hours.ago,
      :end_time => 1.hours.ago
    ))
  end

  it "renders new availability form" do
    render

    assert_select "form[action=?][method=?]", availabilities_path, "post" do

      assert_select "select#availability_status[name=?]", "availability[status]"

      assert_select "textarea#availability_description[name=?]", "availability[description]"
    end
  end
end
