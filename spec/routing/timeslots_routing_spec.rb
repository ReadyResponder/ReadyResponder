require "spec_helper"

describe TimecardsController do
  describe "routing" do

    it "routes to #index" do
      get("/timecards").should route_to("timecards#index")
    end

    it "routes to #new" do
      get("/timecards/new").should route_to("timecards#new")
    end

    it "routes to #show" do
      get("/timecards/1").should route_to("timecards#show", :id => "1")
    end

    it "routes to #edit" do
      get("/timecards/1/edit").should route_to("timecards#edit", :id => "1")
    end

    it "routes to #create" do
      post("/timecards").should route_to("timecards#create")
    end

    it "routes to #update" do
      put("/timecards/1").should route_to("timecards#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/timecards/1").should route_to("timecards#destroy", :id => "1")
    end

  end
end
