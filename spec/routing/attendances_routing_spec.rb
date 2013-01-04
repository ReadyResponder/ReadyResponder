require "spec_helper"

describe AttendancesController do
  describe "routing" do

    it "routes to #index" do
      get("/attendances").should route_to("attendances#index")
    end

    it "routes to #new" do
      get("/attendances/new").should route_to("attendances#new")
    end

    it "routes to #show" do
      get("/attendances/1").should route_to("attendances#show", :id => "1")
    end

    it "routes to #edit" do
      get("/attendances/1/edit").should route_to("attendances#edit", :id => "1")
    end

    it "routes to #create" do
      post("/attendances").should route_to("attendances#create")
    end

    it "routes to #update" do
      put("/attendances/1").should route_to("attendances#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/attendances/1").should route_to("attendances#destroy", :id => "1")
    end

  end
end
