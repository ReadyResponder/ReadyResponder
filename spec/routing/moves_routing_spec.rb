require "spec_helper"

describe MovesController do
  describe "routing" do

    it "routes to #index" do
      get("/moves").should route_to("moves#index")
    end

    it "routes to #new" do
      get("/moves/new").should route_to("moves#new")
    end

    it "routes to #show" do
      get("/moves/1").should route_to("moves#show", :id => "1")
    end

    it "routes to #edit" do
      get("/moves/1/edit").should route_to("moves#edit", :id => "1")
    end

    it "routes to #create" do
      post("/moves").should route_to("moves#create")
    end

    it "routes to #update" do
      put("/moves/1").should route_to("moves#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/moves/1").should route_to("moves#destroy", :id => "1")
    end

  end
end
