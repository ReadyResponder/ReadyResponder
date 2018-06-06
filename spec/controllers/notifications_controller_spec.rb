require 'rails_helper'

# https://github.com/plataformatec/devise/wiki/How-To:-Test-controllers-with-Rails-3-and-4-(and-RSpec)

RSpec.describe NotificationsController, type: :controller do
  let(:event) { FactoryBot.create(:event) }
  let(:department) { create(:department) }
  let!(:notification)  { create(:notification,
                                event: event,
                                subject: "Howdy from Hopedale",
                                departments: [department]) }

  before { login_admin }

  it "should have a current_user" do
    expect(subject.current_user).to_not eq(nil)
  end

  describe "GET" do
    it "should get index" do
      get 'index'
      expect(response).to be_successful
    end
  end

  describe "GET #edit" do
    it "assigns the requested notification" do
      event.notifications << notification
      get :edit, params: { id: notification.to_param }
      expect(assigns(:notification)).to eq(notification)
    end
  end

  describe 'POST #create' do
    let(:notification_params) { { notification: {} } }
    let(:notification) do
      FactoryBot.build(:notification,
                        status: 'Active',
                        event: FactoryBot.create(:event),
                        departments: [FactoryBot.build(:department)])
    end

    before do
      allow(Notification).to receive(:new) { notification }
    end

    context 'successfully initialized client' do
      it 'delivers the notification' do
        expect(notification).to receive(:activate!)
        post :create, params: { notification: { subject: anything } }
        expect(subject).to redirect_to(notification.event)
      end
    end

    context 'unsuccessfully initialized client' do
      it 'rescues an error and sets a flash message' do
        expect(notification).to receive(:activate!)
                            .and_raise(Message::SendNotificationTextMessage::InvalidClient)
        post :create, params: { notification: { subject: anything } }
        expect(subject).to render_template(:new)
      end
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
