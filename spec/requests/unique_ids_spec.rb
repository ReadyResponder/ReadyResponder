require 'rails_helper'

RSpec.describe "UniqueIds", :type => :request do
  describe "Denies public access to unique_ids", type: :request do
    before(:all) do
      @unique_id = create :unique_id
    end

    it "unique_ids#create" do
      unique_id_attributes = FactoryGirl.attributes_for(:unique_id)

      expect {
        post "/unique_ids", { unique_id: unique_id_attributes }
      }.to_not change(UniqueId, :count)

      expect(response).to redirect_to new_user_session_path
    end

    it "unique_ids#delete" do
      delete unique_id_path(id: @unique_id.id)
      expect(response).to redirect_to new_user_session_path
    end

    it "unique_ids#edit" do
      get edit_unique_id_path(id: @unique_id.id)
      expect(response).to redirect_to new_user_session_path
    end

    it "unique_ids#index" do
      get unique_ids_path
      expect(response).to redirect_to new_user_session_path
    end

    it "unique_ids#show" do
      get unique_id_path(id: @unique_id.id)
      expect(response).to redirect_to new_user_session_path
    end

    it "unique_ids#update" do
      unique_id_attributes = @unique_id.attributes.except("id", "created_at", "updated_at")
      patch unique_id_path(id: @unique_id.id), { unique_id: unique_id_attributes }
      expect(response).to redirect_to new_user_session_path
    end
  end
end
