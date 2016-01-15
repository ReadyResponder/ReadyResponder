require 'spec_helper'

describe "inspections/index" do
  before(:each) do
    assign(:inspections, [
      stub_model(Inspection),
      stub_model(Inspection)
    ])
  end

  it "renders a list of inspections" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
