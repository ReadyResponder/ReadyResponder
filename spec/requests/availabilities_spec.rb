require 'rails_helper'

RSpec.describe "Availabilities", type: :request do
  describe "GET /availabilities" do
    it "works! (now write some real specs)" do
      get availabilities_path
      expect(response).to have_http_status(200)
    end
  end
end
