require 'rails_helper'

RSpec.describe "notifications/edit", type: :view do
  before(:each) do
    @event = create(:event)
    department = create(:department)
    @notification = assign(:notification, Notification.create!(
      :event => @event,
      :status => "Active",
      :subject => "Please respond",
      :channels => "voice",
      :departments => [department]
    ))

  end

  it "renders the edit notification form" do
    render

    assert_select "form[action=?][method=?]", notification_path(@notification), "post" do

      assert_select "select#notification_event_id[name=?]", "notification[event_id]"

      assert_select "select#notification_status[name=?]", "notification[status]"

      assert_select "select#notification_channels[name=?]", "notification[channels]"
    end
  end
end
