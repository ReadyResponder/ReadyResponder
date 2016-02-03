require 'rails_helper'

RSpec.describe "Resourcetypes", :type => :request do
  describe "GET /resourcetypes" do
    it "works! (now write some real specs)" do
      get resourcetypes_path
      expect(response).to have_http_status(200)
    end
  end
end
