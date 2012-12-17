require "spec_helper"

describe RepairsController do
  describe "routing" do

    it "routes to #index" do
      get("/repairs").should route_to("repairs#index")
    end

    it "routes to #new" do
      get("/repairs/new").should route_to("repairs#new")
    end

    it "routes to #show" do
      get("/repairs/1").should route_to("repairs#show", :id => "1")
    end

    it "routes to #edit" do
      get("/repairs/1/edit").should route_to("repairs#edit", :id => "1")
    end

    it "routes to #create" do
      post("/repairs").should route_to("repairs#create")
    end

    it "routes to #update" do
      put("/repairs/1").should route_to("repairs#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/repairs/1").should route_to("repairs#destroy", :id => "1")
    end

  end
end
