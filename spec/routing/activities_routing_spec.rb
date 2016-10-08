require "rails_helper"

describe ActivitiesController do
  describe "routing" do

    it "routes to #index" do
      expect(get("/activities")).to route_to("activities#index")
    end

    it "routes to #new" do
      expect(get("/activities/new")).to route_to("activities#new")
    end

    it "routes to #show" do
      expect(get("/activities/1")).to route_to("activities#show", :id => "1")
    end

    it "routes to #edit" do
      expect(get("/activities/1/edit")).to route_to("activities#edit", :id => "1")
    end

    it "routes to #create" do
      expect(post("/activities")).to route_to("activities#create")
    end

    it "routes to #update" do
      expect(put("/activities/1")).to route_to("activities#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(delete("/activities/1")).to route_to("activities#destroy", :id => "1")
    end

  end
end
