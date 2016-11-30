require "rails_helper"

RSpec.describe RecipientsController, type: :routing do
  describe "routing" do

    it "routes to #new" do
      expect(:get => "/recipients/new").to route_to("recipients#new")
    end

    it "routes to #show" do
      expect(:get => "/recipients/1").to route_to("recipients#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/recipients/1/edit").to route_to("recipients#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/recipients").to route_to("recipients#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/recipients/1").to route_to("recipients#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/recipients/1").to route_to("recipients#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/recipients/1").to route_to("recipients#destroy", :id => "1")
    end

  end
end
