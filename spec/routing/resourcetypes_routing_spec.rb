require "rails_helper"

RSpec.describe ResourcetypesController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/resourcetypes").to route_to("resourcetypes#index")
    end

    it "routes to #new" do
      expect(:get => "/resourcetypes/new").to route_to("resourcetypes#new")
    end

    it "routes to #show" do
      expect(:get => "/resourcetypes/1").to route_to("resourcetypes#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/resourcetypes/1/edit").to route_to("resourcetypes#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/resourcetypes").to route_to("resourcetypes#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/resourcetypes/1").to route_to("resourcetypes#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/resourcetypes/1").to route_to("resourcetypes#destroy", :id => "1")
    end

  end
end
