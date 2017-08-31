require 'rails_helper'

RSpec.describe "notifications/show", type: :view do
  before(:each) do
    department = create(:department)
    @notification = assign(:notification, Notification.create!(
      :event => nil,
      :status => "Active",
      :channels => "Email, Text",
      :departments => [department]
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Status/)
    expect(rendered).to match(/Active/)
  end
end
