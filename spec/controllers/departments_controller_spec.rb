require 'rails_helper'

RSpec.describe DepartmentsController do

  before(:each) { login_admin }

  describe "GET orgchart" do
    let!(:department) { create(:department) }

    # catch view rendering errors
    render_views

    it "shows an orgchart" do
      get :orgchart, params: { id: department.id }
      expect(response).to be_successful
    end

    context "as a reader" do
      before(:each) { login_as('Reader') }

      it "has no permission to orgchart" do
        get :orgchart, params: { id: department.id }
        expect(response).to be_redirect
      end
    end

    it "returns 404 on not found" do
      expect {
        get :orgchart, params: { id: -1 }
      }.to raise_error ActiveRecord::RecordNotFound
    end
  end

end
