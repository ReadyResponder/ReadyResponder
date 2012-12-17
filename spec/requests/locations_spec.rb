require 'spec_helper'

describe "Locations" do
  describe "GET /locations" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get locations_path
      response.status.should be(200)
    end
  end
end
