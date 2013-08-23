require "spec_helper"

describe HelpdocsController do
  describe "routing" do

    it "routes to #index" do
      get("/helpdocs").should route_to("helpdocs#index")
    end

    it "routes to #new" do
      get("/helpdocs/new").should route_to("helpdocs#new")
    end

    it "routes to #show" do
      get("/helpdocs/1").should route_to("helpdocs#show", :id => "1")
    end

    it "routes to #edit" do
      get("/helpdocs/1/edit").should route_to("helpdocs#edit", :id => "1")
    end

    it "routes to #create" do
      post("/helpdocs").should route_to("helpdocs#create")
    end

    it "routes to #update" do
      put("/helpdocs/1").should route_to("helpdocs#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/helpdocs/1").should route_to("helpdocs#destroy", :id => "1")
    end

  end
end
