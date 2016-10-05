require "spec_helper"

RSpec.describe DepartmentsController, :type => :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/departments").to route_to("departments#index")
    end

    it "routes to #new" do
      expect(:get => "/departments/new").to route_to("departments#new")
    end

    it "routes to #show" do
      expect(:get => "/departments/1").to route_to("departments#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/departments/1/edit").to route_to("departments#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/departments").to route_to("departments#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/departments/1").to route_to("departments#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/departments/1").to route_to("departments#destroy", :id => "1")
    end

  end
end
