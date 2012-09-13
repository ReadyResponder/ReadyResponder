require 'spec_helper'

describe "inspections/edit" do
  before(:each) do
    @inspection = assign(:inspection, stub_model(Inspection,
      :person_id => 1
    ))
  end

  it "renders the edit inspection form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => inspections_path(@inspection), :method => "post" do
      assert_select "input#inspection_person_id", :name => "inspection[person_id]"
    end
  end
end
