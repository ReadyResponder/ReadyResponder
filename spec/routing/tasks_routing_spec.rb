require "spec_helper"

describe TasksController do
  describe "routing" do

    it "routes to #index" do
      expect(get("/tasks")).to route_to("tasks#index")
    end

    it "routes to #new" do
      expect(get("/events/3/tasks/new")).to route_to("tasks#new", event_id: "3")
      expect(get("/tasks/new")).to_not be_routable
    end

    it "routes to #show" do
      expect(get("/tasks/1")).to route_to("tasks#show", :id => "1")
      expect(get("/tasks/123new")).to_not be_routable
      expect(get("/tasks/new123")).to_not be_routable
    end

    it "routes to #edit" do
      expect(get("/tasks/1/edit")).to route_to("tasks#edit", :id => "1")
    end

    it "routes to #create" do
      expect(post("/events/3/tasks")).to route_to("tasks#create", event_id: "3")
      expect(post("/tasks")).to_not be_routable
    end

    it "routes to #update" do
      expect(put("/tasks/1")).to route_to("tasks#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(delete("/tasks/1")).to route_to("tasks#destroy", :id => "1")
    end

  end
end
