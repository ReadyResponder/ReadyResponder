require "rails_helper"

RSpec.describe RepairsController do
  describe "routing" do

    it "routes to #index" do
      expect(get("/repairs")).to route_to("repairs#index")
    end

    it "routes to #new" do
      expect(get("/repairs/new")).to route_to("repairs#new")
    end

    it "routes to #show" do
      expect(get("/repairs/1")).to route_to("repairs#show", :id => "1")
    end

    it "routes to #edit" do
      expect(get("/repairs/1/edit")).to route_to("repairs#edit", :id => "1")
    end

    it "routes to #create" do
      expect(post("/repairs")).to route_to("repairs#create")
    end

    it "routes to #update" do
      expect(put("/repairs/1")).to route_to("repairs#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(delete("/repairs/1")).to route_to("repairs#destroy", :id => "1")
    end

  end
end
