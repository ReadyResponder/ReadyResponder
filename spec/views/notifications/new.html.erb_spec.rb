require 'rails_helper'

RSpec.describe "notifications/new", type: :view do
  before(:each) do
    @event = FactoryGirl.create(:event)
    assign(:notification, Notification.new(
      :event => @event,
      :status => "Active",
      :subject => "Please respond",
      :channels => "Text"
    ))
  end

  it "renders new notification form" do
    render

    assert_select "form[action=?][method=?]", notifications_path, "post" do
      assert_select "select#notification_status[name=?]", "notification[status]"
      assert_select "select#notification_channels[name=?]", "notification[channels]"
    end
  end
end
