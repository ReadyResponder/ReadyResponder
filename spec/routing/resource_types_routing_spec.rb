require "spec_helper"

RSpec.describe ResourceTypesController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/resource_types").to route_to("resource_types#index")
    end

    it "routes to #new" do
      expect(:get => "/resource_types/new").to route_to("resource_types#new")
    end

    it "routes to #show" do
      expect(:get => "/resource_types/1").to route_to("resource_types#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/resource_types/1/edit").to route_to("resource_types#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/resource_types").to route_to("resource_types#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/resource_types/1").to route_to("resource_types#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/resource_types/1").to route_to("resource_types#destroy", :id => "1")
    end

  end
end
