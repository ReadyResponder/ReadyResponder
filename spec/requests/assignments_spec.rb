require 'rails_helper'

RSpec.describe "assignments", :type => :request do
  describe "Denies public access to assignments", type: :request do
    before(:all) do
      @assignment = create :assignment
    end

    it "assignments#create" do
      assignment_attributes = FactoryGirl.attributes_for(:assignment)

      expect {
        post "/assignments", { assignment: assignment_attributes }
      }.to_not change(Assignment, :count)

      expect(response).to redirect_to new_user_session_path
    end

    it "assignments#delete" do
      delete assignment_path(id: @assignment.id)
      expect(response).to redirect_to new_user_session_path
    end

    it "assignments#edit" do
      get edit_assignment_path(id: @assignment.id)
      expect(response).to redirect_to new_user_session_path
    end

    it "assignments#index" do
      get assignments_path
      expect(response).to redirect_to new_user_session_path
    end

    it "assignments#new" do
      get new_assignment_path
      expect(response).to redirect_to new_user_session_path
    end

    it "assignments#show" do
      get assignment_path(id: @assignment.id)
      expect(response).to redirect_to new_user_session_path
    end

    it "assignments#update" do
      assignment_attributes = @assignment.attributes.except("id", "created_at", "updated_at")
      patch assignment_path(id: @assignment.id), { assignment: assignment_attributes }
      expect(response).to redirect_to new_user_session_path
    end
  end
end
