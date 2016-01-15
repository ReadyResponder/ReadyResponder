require 'spec_helper'

describe "inspections/edit" do
  before(:each) do
    @inspection = assign(:inspection, stub_model(Inspection))
  end

  it "renders the edit inspection form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", inspection_path(@inspection), "post" do
    end
  end
end
