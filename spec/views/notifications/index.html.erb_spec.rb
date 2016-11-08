require 'rails_helper'

RSpec.describe "notifications/index", type: :view do
  let(:user) { FactoryGirl.create :user }
  before(:each) do
    assign(:notifications, [
      Notification.create!(
        :event => nil,
        :status => "active",
        :channels => "Channels"
      ),
      Notification.create!(
        :event => nil,
        :status => "active",
        :channels => "Channels"
      )
    ])
    allow(controller).to receive(:current_user).and_return(user)
  end

  it "renders a list of notifications" do
    render
    assert_select "tr>td", :text => 'None', :count => 2
    assert_select "tr>td", :text => "active".to_s, :count => 2
    assert_select "tr>td", :text => "Channels".to_s, :count => 2
  end
end
