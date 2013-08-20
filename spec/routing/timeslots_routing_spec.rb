require "spec_helper"

describe TimeslotsController do
  describe "routing" do

    it "routes to #index" do
      get("/timeslots").should route_to("timeslots#index")
    end

    it "routes to #new" do
      get("/timeslots/new").should route_to("timeslots#new")
    end

    it "routes to #show" do
      get("/timeslots/1").should route_to("timeslots#show", :id => "1")
    end

    it "routes to #edit" do
      get("/timeslots/1/edit").should route_to("timeslots#edit", :id => "1")
    end

    it "routes to #create" do
      post("/timeslots").should route_to("timeslots#create")
    end

    it "routes to #update" do
      put("/timeslots/1").should route_to("timeslots#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/timeslots/1").should route_to("timeslots#destroy", :id => "1")
    end

  end
end
