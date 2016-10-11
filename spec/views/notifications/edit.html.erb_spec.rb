require 'rails_helper'

RSpec.describe "notifications/edit", type: :view do
  before(:each) do
    @notification = assign(:notification, Notification.create!(
      :event => nil,
      :status => "active",
      :channels => "MyString"
    ))
  end

  it "renders the edit notification form" do
    render

    assert_select "form[action=?][method=?]", notification_path(@notification), "post" do

      assert_select "input#notification_event_id[name=?]", "notification[event_id]"

      assert_select "input#notification_status[name=?]", "notification[status]"

      assert_select "input#notification_channels[name=?]", "notification[channels]"
    end
  end
end
