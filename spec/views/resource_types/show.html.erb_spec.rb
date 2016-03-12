require 'rails_helper'

RSpec.describe "resource_types/show", :type => :view do
  before(:each) do
    @resource_type = assign(:resource_type, ResourceType.create!(
      :name => "Name",
      :status => "Status",
      :description => "MyText",
      :fema_code => "Fema Code",
      :fema_kind => "Fema Kind"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Status/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/Fema Code/)
    expect(rendered).to match(/Fema Kind/)
  end
end
