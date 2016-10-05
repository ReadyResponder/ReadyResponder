require 'rails_helper'

RSpec.describe "departments/show", :type => :view do
  before(:each) do
    @department = assign(:department, Department.create!(
      :name => "Name",
      :status => "Status",
      :contact_id => 1,
      :description => "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Status/)
    expect(rendered).to match(/1/)
    expect(rendered).to match(/MyText/)
  end
end
