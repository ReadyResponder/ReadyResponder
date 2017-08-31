require 'rails_helper'

RSpec.describe "notifications/index", type: :view do
  let(:user) { FactoryGirl.create :user }
  let(:department) { create(:department) }

  before(:each) do
    assign(:notifications, [
      Notification.create!(
        :event => create(:event),
        :status => "Active",
        :channels => "Text",
        :departments => [department]
      ),
      Notification.create!(
        :event => create(:event),
        :status => "Complete",
        :channels => "EMail",
        :departments => [department]
      )
    ])
    allow(controller).to receive(:current_user).and_return(user)
  end

  it "renders a list of notifications" do
    render
    assert_select "tr>td", :text => "Active".to_s, :count => 1
    assert_select "tr>td", :text => "Complete".to_s, :count => 1
  end
end
