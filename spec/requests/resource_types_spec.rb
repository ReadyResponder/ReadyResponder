require 'spec_helper'

RSpec.describe "ResourceTypes", :type => :request do
  describe "GET /resource_types" do
    it "works! (now write some real specs)" do
      get resource_types_path
      expect(response).to have_http_status(200)
    end
  end
end
