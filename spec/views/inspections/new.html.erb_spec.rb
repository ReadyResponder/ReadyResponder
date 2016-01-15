require 'spec_helper'

describe "inspections/new" do
  before(:each) do
    assign(:inspection, stub_model(Inspection).as_new_record)
  end

  it "renders new inspection form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form[action=?][method=?]", inspections_path, "post" do
    end
  end
end
