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
    rendered.should match(/Content/)
    rendered.should match(/Author/)
    rendered.should match(/1/)
    rendered.should match(/Loggable Type/)
  end
end
