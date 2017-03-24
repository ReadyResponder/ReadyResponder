require 'rails_helper'

RSpec.describe "Availabilities", type: :request do
  describe "Denies public access to availabilities", type: :request do
    before(:all) do
      @availability = build :availability
    end

    it "availabilities#create" do
      availability_attributes = FactoryGirl.attributes_for(:availability)

      expect {
        post "/availabilities", { availability: availability_attributes }
      }.to_not change(Availability, :count)

      expect(response).to redirect_to new_user_session_path
    end

    it "availabilities#delete" do
      allow(@availability).to receive(:id).and_return(1)
      delete availability_path(id: @availability.id)
      expect(response).to redirect_to new_user_session_path
    end

    it "availabilities#edit" do
      allow(@availability).to receive(:id).and_return(1)
      get edit_availability_path(id: @availability.id)
      expect(response).to redirect_to new_user_session_path
    end

    it "availabilities#index" do
      get availabilities_path
      expect(response).to redirect_to new_user_session_path
    end

    it "availabilities#show" do
      allow(@availability).to receive(:id).and_return(1)
      get availability_path(id: @availability.id)
      expect(response).to redirect_to new_user_session_path
    end

    it "availabilities#update" do
      allow(@availability).to receive(:id).and_return(1)
      availability_attributes = @availability.attributes.except("id", "created_at", "updated_at")
      patch availability_path(id: @availability.id), { availability: availability_attributes }
      expect(response).to redirect_to new_user_session_path
    end
  end
end
