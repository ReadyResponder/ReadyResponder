require "spec_helper"

describe InspectionsController do
  describe "routing" do

    it "routes to #index" do
      get("/inspections").should route_to("inspections#index")
    end

    it "routes to #new" do
      get("/inspections/new").should route_to("inspections#new")
    end

    it "routes to #show" do
      get("/inspections/1").should route_to("inspections#show", :id => "1")
    end

    it "routes to #edit" do
      get("/inspections/1/edit").should route_to("inspections#edit", :id => "1")
    end

    it "routes to #create" do
      post("/inspections").should route_to("inspections#create")
    end

    it "routes to #update" do
      put("/inspections/1").should route_to("inspections#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/inspections/1").should route_to("inspections#destroy", :id => "1")
    end

  end
end
