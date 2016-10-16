require "rails_helper"

RSpec.describe ItemTypesController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/item_types").to route_to("item_types#index")
    end

    it "routes to #new" do
      expect(:get => "/item_types/new").to route_to("item_types#new")
    end

    it "routes to #show" do
      expect(:get => "/item_types/1").to route_to("item_types#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/item_types/1/edit").to route_to("item_types#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/item_types").to route_to("item_types#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/item_types/1").to route_to("item_types#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/item_types/1").to route_to("item_types#destroy", :id => "1")
    end

  end
end
