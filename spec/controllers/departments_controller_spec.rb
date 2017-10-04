require 'rails_helper'

RSpec.describe DepartmentsController do
  
  before(:each) { login_admin }

  describe "GET orgchart" do
    let!(:department) { create(:department) }
    
    # catch view rendering errors
    render_views
    
    it "shows an orgchart" do
      get :orgchart, {id: department.id}
      expect(response).to be_success
    end
    
    context "as a reader" do
      before(:each) { login_as('Reader') }
      
      it "has no permission to orgchart" do
        get :orgchart, {id: department.id}
        expect(response).to be_redirect
      end
    end
    
    it "returns 404 on not found" do
      expect {
        get :orgchart, {id: -1}
      }.to raise_error ActiveRecord::RecordNotFound
    end
  end

end
