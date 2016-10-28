require 'rails_helper'

RSpec.describe "notifications/new", type: :view do
  before(:each) do
    assign(:notification, Notification.new(
      :event => nil,
      :status => "active",
      :channels => "MyString"
    ))
  end

  it "renders new notification form" do
    render

    assert_select "form[action=?][method=?]", notifications_path, "post" do
      assert_select "select#notification_event_id[name=?]", "notification[event_id]"
      assert_select "select#notification_status[name=?]", "notification[status]"
      assert_select "textarea#notification_channels[name=?]", "notification[channels]"
    end
  end
end
