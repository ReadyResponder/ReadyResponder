require 'spec_helper'

describe "inspections/new" do
  before(:each) do
    assign(:inspection, stub_model(Inspection,
      :person_id => 1
    ).as_new_record)
  end

  it "renders new inspection form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => inspections_path, :method => "post" do
      assert_select "input#inspection_person_id", :name => "inspection[person_id]"
    end
  end
end
