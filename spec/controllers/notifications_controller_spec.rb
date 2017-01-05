require 'rails_helper'

# https://github.com/plataformatec/devise/wiki/How-To:-Test-controllers-with-Rails-3-and-4-(and-RSpec)

RSpec.describe NotificationsController, type: :controller do
  let(:event) { FactoryGirl.create(:event) }
  let(:valid_attributes) {
    FactoryGirl.attributes_for(:notification)
  }

  before { login_admin }

  it "should have a current_user" do
    expect(subject.current_user).to_not eq(nil)
  end

  describe "GET" do
    it "should get index" do
      get 'index'
      expect(response).to be_success
    end
  end

  describe "GET #edit" do
    it "assigns the requested notification" do
      notification = Notification.create! valid_attributes
      event.notifications << notification
      get :edit, {:id => notification.to_param}
      expect(assigns(:notification)).to eq(notification)
    end
  end

  describe "UPDATE" do
    # it "re-renders the 'edit' template"
  end

  describe "PUT #update" do
    # context "with valid params" do
    #   it "updates the requested notification"
    #   it "assigns the requested notification as @notification"
    #   it "redirects to the notification"
    # end
    #
    # context "with invalid params" do
    #   it "assigns the notification as @notification"
    #   it "re-renders the 'edit' template"
    # end
  end

  describe "DELETE #destroy" do
    # it "destroys the requested notification"
    # it "redirects to the notifications list"
  end

end
