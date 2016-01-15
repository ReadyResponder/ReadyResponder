require 'spec_helper'

describe "inspections/show" do
  before(:each) do
    @inspection = assign(:inspection, stub_model(Inspection))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
  end
end
