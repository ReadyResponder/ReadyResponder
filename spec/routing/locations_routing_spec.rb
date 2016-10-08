require "rails_helper"

describe LocationsController do
  describe "routing" do

    it "routes to #index" do
      expect(get("/locations")).to route_to("locations#index")
    end

    it "routes to #new" do
      expect(get("/locations/new")).to route_to("locations#new")
    end

    it "routes to #show" do
      expect(get("/locations/1")).to route_to("locations#show", :id => "1")
    end

    it "routes to #edit" do
      expect(get("/locations/1/edit")).to route_to("locations#edit", :id => "1")
    end

    it "routes to #create" do
      expect(post("/locations")).to route_to("locations#create")
    end

    it "routes to #update" do
      expect(put("/locations/1")).to route_to("locations#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(delete("/locations/1")).to route_to("locations#destroy", :id => "1")
    end

  end
end
