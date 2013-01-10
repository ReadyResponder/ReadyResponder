require "spec_helper"

describe ChannelsController do
  describe "routing" do

    it "routes to #index" do
      get("/channels").should route_to("channels#index")
    end

    it "routes to #new" do
      get("/channels/new").should route_to("channels#new")
    end

    it "routes to #show" do
      get("/channels/1").should route_to("channels#show", :id => "1")
    end

    it "routes to #edit" do
      get("/channels/1/edit").should route_to("channels#edit", :id => "1")
    end

    it "routes to #create" do
      post("/channels").should route_to("channels#create")
    end

    it "routes to #update" do
      put("/channels/1").should route_to("channels#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/channels/1").should route_to("channels#destroy", :id => "1")
    end

  end
end
