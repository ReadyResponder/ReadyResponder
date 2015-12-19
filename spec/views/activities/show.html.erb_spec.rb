require 'spec_helper'

describe "activities/show" do
  before(:each) do
    @activity = assign(:activity, stub_model(Activity,
      :content => "Content",
      :author => "Author",
      :loggable_id => 1,
      :loggable_type => "Loggable Type"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    expect(rendered).to match(/Content/)
    expect(rendered).to match(/Author/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/Loggable Type/)
  end
end
