require 'rails_helper'

RSpec.describe DepartmentsController do
  
  before(:each) { login_admin }

  describe "GET orgchart" do
    let!(:department) { create(:department) }
    
    # catch view rendering errors
    render_views
    
    it "shows an orgchart" do
      get :orgchart, {dept_id: department.id}
      expect(response).to be_success
    end
    
    it "returns 404 on not found" do
      get :orgchart, {dept_id: -1}
      expect(response.code).to eq "404"
    end
  end

end
