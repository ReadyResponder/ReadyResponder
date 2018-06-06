require 'rails_helper'

RSpec.describe "Departments", :type => :request do
  describe "Denies public access to Departments", type: :request do
    before(:all) do
      @department = create :department
    end

    it "departments#create" do
      department_attributes = FactoryBot.attributes_for(:department)

      expect {
        post "/departments", params: { department: department_attributes }
      }.to_not change(Department, :count)

      expect(response).to redirect_to new_user_session_path
    end

    it "departments#delete" do
      delete department_path(id: @department.id)
      expect(response).to redirect_to new_user_session_path
    end

    it "departments#edit" do
      get edit_department_path(id: @department.id)
      expect(response).to redirect_to new_user_session_path
    end

    it "departments#index" do
      get departments_path
      expect(response).to redirect_to new_user_session_path
    end

    it "departments#new" do
      get new_department_path
      expect(response).to redirect_to new_user_session_path
    end

    it "departments#show" do
      get department_path(id: @department.id)
      expect(response).to redirect_to new_user_session_path
    end

    it "departments#update" do
      department_attributes = @department.attributes.except("id", "created_at", "updated_at")
      patch department_path(id: @department.id), params: { department: department_attributes }
      expect(response).to redirect_to new_user_session_path
    end
  end
end
