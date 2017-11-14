require 'rails_helper'

RSpec.describe VendorsController, type: :controller do
  let!(:amazon) { create(:vendor) }
  let!(:item) { create(:item, vendor: amazon) }

  before { login_admin }

  describe "#index" do
    it "it displays all vendors" do
      get :index

      expect(assigns[:vendors]).to eq (Vendor.all)
      expect(response).to be_success
    end
  end

  describe "#show" do
    it "displays the items" do
      get :show, id: amazon.id

    expect(assigns[:vendor]).to eq (amazon)
    expect(assigns[:items]).to include (item)
    end
  end

  describe "#new" do
    it "shows a form" do
      get :new, id: amazon.id
    expect(response).to render_template :new
    end
  end

  describe "#create" do
    context "with valid params" do
      before do
        @vendor_params = { name: "Ships", status: "Avaiable" }
      end
      it "creates a new vendor" do
        post :create, vendor: @vendor_params, next: new_item_path
      expect(response).to redirect_to new_item_path
      end

      it "creates a new vendor" do
        post :create, vendor: @vendor_params, next: vendors_path
      expect(response).to redirect_to vendors_path
      expect(flash[:notice]).to eq "Vendor was successfully created"
      end
    end
  end
end
