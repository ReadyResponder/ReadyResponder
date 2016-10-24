require "rails_helper"

RSpec.describe RequirementsController do
  describe "routing" do

    it "routes to #index" do
      expect(get("/requirements")).to route_to("requirements#index")
    end

    it "routes to #new" do
      expect(get("/tasks/3/requirements/new")).to route_to("requirements#new", task_id: "3")
      expect(get("/requirements/new")).to_not be_routable
    end

    it "routes to #show" do
      expect(get("/requirements/1")).to route_to("requirements#show", :id => "1")
      expect(get("/requirements/123new")).to_not be_routable
      expect(get("/requirements/new123")).to_not be_routable
    end

    it "routes to #edit" do
      expect(get("/requirements/1/edit")).to route_to("requirements#edit", :id => "1")
    end

    it "routes to #create" do
      expect(post("/tasks/3/requirements")).to route_to("requirements#create", task_id: "3")
      expect(post("/requirements")).to_not be_routable
    end

    it "routes to #update" do
      expect(put("/requirements/1")).to route_to("requirements#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(delete("/requirements/1")).to route_to("requirements#destroy", :id => "1")
    end

  end
end
