require 'spec_helper'

describe "helpdocs/show" do
  before(:each) do
    @helpdoc = assign(:helpdoc, stub_model(Helpdoc,
      :title => "Title",
      :contents => "MyText",
      :help_for_view => "Help For View",
      :help_for_section => "Help For Section"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Help For View/)
    expect(rendered).to match(/Help For Section/)
  end
end
