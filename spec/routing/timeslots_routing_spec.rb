require "rails_helper"

RSpec.describe TimecardsController do
  describe "routing" do

    it "routes to #index" do
      expect(get("/timecards")).to route_to("timecards#index")
    end

    it "routes to #new" do
      expect(get("/timecards/new")).to route_to("timecards#new")
    end

    it "routes to #show" do
      expect(get("/timecards/1")).to route_to("timecards#show", :id => "1")
    end

    it "routes to #edit" do
      expect(get("/timecards/1/edit")).to route_to("timecards#edit", :id => "1")
    end

    it "routes to #create" do
      expect(post("/timecards")).to route_to("timecards#create")
    end

    it "routes to #update" do
      expect(put("/timecards/1")).to route_to("timecards#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(delete("/timecards/1")).to route_to("timecards#destroy", :id => "1")
    end

  end
end
