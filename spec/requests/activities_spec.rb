require 'rails_helper'

RSpec.describe "Activities" do
  describe "GET /activities" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get activities_path
      expect(response.status).to be(200)
    end
  end
end
