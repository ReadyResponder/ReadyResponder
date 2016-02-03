require 'rails_helper'

RSpec.describe "resourcetypes/show", :type => :view do
  before(:each) do
    @resourcetype = assign(:resourcetype, Resourcetype.create!(
      :name => "Name",
      :femakind => "Femakind",
      :femacode => "Femacode",
      :status => "Status",
      :description => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Femakind/)
    expect(rendered).to match(/Femacode/)
    expect(rendered).to match(/Status/)
    expect(rendered).to match(/MyText/)
  end
end
