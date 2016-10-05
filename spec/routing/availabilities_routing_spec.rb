require "rails_helper"

RSpec.describe AvailabilitiesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/availabilities").to route_to("availabilities#index")
    end

    it "routes to #new" do
      expect(:get => "/availabilities/new").to route_to("availabilities#new")
    end

    it "routes to #show" do
      expect(:get => "/availabilities/1").to route_to("availabilities#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/availabilities/1/edit").to route_to("availabilities#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/availabilities").to route_to("availabilities#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/availabilities/1").to route_to("availabilities#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/availabilities/1").to route_to("availabilities#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/availabilities/1").to route_to("availabilities#destroy", :id => "1")
    end

  end
end
