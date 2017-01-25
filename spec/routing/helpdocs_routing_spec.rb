require "rails_helper"

RSpec.describe HelpdocsController do
  describe "routing" do

    it "routes to #index" do
      expect(get("/helpdocs")).to route_to("helpdocs#index")
    end

    it "routes to #show" do
      expect(get("/helpdocs/foo")).to route_to("helpdocs#show", :id => "foo")
    end
  end
end
