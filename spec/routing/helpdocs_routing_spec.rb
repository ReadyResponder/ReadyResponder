require "spec_helper"

describe HelpdocsController do
  describe "routing" do

    it "routes to #index" do
      expect(get("/helpdocs")).to route_to("helpdocs#index")
    end

    it "routes to #new" do
      expect(get("/helpdocs/new")).to route_to("helpdocs#new")
    end

    it "routes to #show" do
      expect(get("/helpdocs/1")).to route_to("helpdocs#show", :id => "1")
    end

    it "routes to #edit" do
      expect(get("/helpdocs/1/edit")).to route_to("helpdocs#edit", :id => "1")
    end

    it "routes to #create" do
      expect(post("/helpdocs")).to route_to("helpdocs#create")
    end

    it "routes to #update" do
      expect(put("/helpdocs/1")).to route_to("helpdocs#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(delete("/helpdocs/1")).to route_to("helpdocs#destroy", :id => "1")
    end

  end
end
