require "spec_helper"

describe InspectionsController do
  describe "routing" do

    it "routes to #index" do
      expect(get("/inspections")).to route_to("inspections#index")
    end

    it "routes to #new" do
      expect(get("/inspections/new")).to route_to("inspections#new")
    end

    it "routes to #show" do
      expect(get("/inspections/1")).to route_to("inspections#show", :id => "1")
    end

    it "routes to #edit" do
      expect(get("/inspections/1/edit")).to route_to("inspections#edit", :id => "1")
    end

    it "routes to #create" do
      expect(post("/inspections")).to route_to("inspections#create")
    end

    it "routes to #update" do
      expect(put("/inspections/1")).to route_to("inspections#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(delete("/inspections/1")).to route_to("inspections#destroy", :id => "1")
    end

  end
end
