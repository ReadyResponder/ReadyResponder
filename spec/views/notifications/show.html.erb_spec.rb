require 'rails_helper'

RSpec.describe "notifications/show", type: :view do
  before(:each) do
    @notification = assign(:notification, Notification.create!(
      :event => nil,
      :status => "Active",
      :channels => "Channels"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Status/)
  end
end
