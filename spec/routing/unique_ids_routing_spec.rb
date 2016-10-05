require "rails_helper"

RSpec.describe UniqueIdsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/unique_ids").to route_to("unique_ids#index")
    end

    it "routes to #new" do
      expect(:get => "/unique_ids/new").to route_to("unique_ids#new")
    end

    it "routes to #show" do
      expect(:get => "/unique_ids/1").to route_to("unique_ids#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/unique_ids/1/edit").to route_to("unique_ids#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/unique_ids").to route_to("unique_ids#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/unique_ids/1").to route_to("unique_ids#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/unique_ids/1").to route_to("unique_ids#destroy", :id => "1")
    end

  end
end
