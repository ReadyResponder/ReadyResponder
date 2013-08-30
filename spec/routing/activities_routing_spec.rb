require "spec_helper"

describe ActivitiesController do
  describe "routing" do

    it "routes to #index" do
      get("/activities").should route_to("activities#index")
    end

    it "routes to #new" do
      get("/activities/new").should route_to("activities#new")
    end

    it "routes to #show" do
      get("/activities/1").should route_to("activities#show", :id => "1")
    end

    it "routes to #edit" do
      get("/activities/1/edit").should route_to("activities#edit", :id => "1")
    end

    it "routes to #create" do
      post("/activities").should route_to("activities#create")
    end

    it "routes to #update" do
      put("/activities/1").should route_to("activities#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/activities/1").should route_to("activities#destroy", :id => "1")
    end

  end
end
