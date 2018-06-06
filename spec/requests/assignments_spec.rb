require 'rails_helper'

RSpec.describe "assignments", :type => :request do
  describe "Denies public access to assignments", type: :request do
    before(:all) do
      @person = create :person
      @assignment = create(:assignment, person_id: @person.id)
    end

    it "assignments#create" do
      assignment_attributes = FactoryBot.attributes_for(:assignment)

      expect {
        post "/requirements/1/assignments", params: { assignment: assignment_attributes }
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

    it "assignments#show" do
      get assignment_path(id: @assignment.id)
      expect(response).to redirect_to new_user_session_path
    end

    it "assignments#update" do
      assignment_attributes = @assignment.attributes.except("id", "created_at", "updated_at")
      patch assignment_path(id: @assignment.id), params: { assignment: assignment_attributes }
      expect(response).to redirect_to new_user_session_path
    end
  end
end
