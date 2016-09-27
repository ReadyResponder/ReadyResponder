require 'rails_helper'

RSpec.describe "notifications/show", type: :view do
  before(:each) do
    @notification = assign(:notification, Notification.create!(
      :event => nil,
      :status => "Status",
      :subject => "Subject",
      :body => "Body",
      :channels => "Channels"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Status/)
    expect(rendered).to match(/Subject/)
    expect(rendered).to match(/Body/)
    expect(rendered).to match(/Channels/)
  end
end
