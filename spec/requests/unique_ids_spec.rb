require 'rails_helper'

RSpec.describe "UniqueIds", :type => :request do
  describe "GET /unique_ids" do
    it "works! (now write some real specs)" do
      get unique_ids_path
      expect(response).to have_http_status(200)
    end
  end
end
