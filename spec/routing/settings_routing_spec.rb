require "rails_helper"

RSpec.describe SettingsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/settings").to route_to("settings#index")
    end

    it "routes to #new" do
      expect(:get => "/settings/new").to route_to("settings#new")
    end

    it "routes to #show" do
      expect(:get => "/settings/1").to route_to("settings#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/settings/1/edit").to route_to("settings#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/settings").to route_to("settings#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/settings/1").to route_to("settings#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/settings/1").to route_to("settings#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/settings/1").to route_to("settings#destroy", :id => "1")
    end

  end
end
