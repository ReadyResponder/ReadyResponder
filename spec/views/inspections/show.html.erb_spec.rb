require 'spec_helper'

describe "inspections/show" do
  before(:each) do
    @inspection = assign(:inspection, stub_model(Inspection,
      :person_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    rendered.should match(/1/)
  end
end
