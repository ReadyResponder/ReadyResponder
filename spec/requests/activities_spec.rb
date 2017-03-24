require 'rails_helper'

RSpec.describe "Activities" do
  describe "Denies public access to activities", type: :request do
    before(:all) do
      @activity = create :activity
    end

    it "activities#create" do
      activity_attributes = FactoryGirl.attributes_for(:activity)

      expect {
        post "/activities", { activity: activity_attributes }
      }.to_not change(Activity, :count)

      expect(response).to redirect_to new_user_session_path
    end

    it "activities#delete" do
      delete activity_path(id: @activity.id)
      expect(response).to redirect_to new_user_session_path
    end

    it "activities#edit" do
      get edit_activity_path(id: @activity.id)
      expect(response).to redirect_to new_user_session_path
    end

    it "activities#index" do
      get activities_path
      expect(response).to redirect_to new_user_session_path
    end

    it "activities#show" do
      get activity_path(id: @activity.id)
      expect(response).to redirect_to new_user_session_path
    end

    it "activities#update" do
      activity_attributes = @activity.attributes.except("id", "created_at", "updated_at")
      patch activity_path(id: @activity.id), { activity: activity_attributes }
      expect(response).to redirect_to new_user_session_path
    end
  end
end
