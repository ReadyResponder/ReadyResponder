require "rails_helper"

describe MovesController do
  describe "routing" do

    it "routes to #index" do
      expect(get("/moves")).to route_to("moves#index")
    end

    it "routes to #new" do
      expect(get("/moves/new")).to route_to("moves#new")
    end

    it "routes to #show" do
      expect(get("/moves/1")).to route_to("moves#show", :id => "1")
    end

    it "routes to #edit" do
      expect(get("/moves/1/edit")).to route_to("moves#edit", :id => "1")
    end

    it "routes to #create" do
      expect(post("/moves")).to route_to("moves#create")
    end

    it "routes to #update" do
      expect(put("/moves/1")).to route_to("moves#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(delete("/moves/1")).to route_to("moves#destroy", :id => "1")
    end

  end
end
