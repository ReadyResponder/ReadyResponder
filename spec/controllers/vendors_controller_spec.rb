require 'rails_helper'

RSpec.describe VendorsController, type: :controller do
  let!(:amazon) { create(:vendor) }
  let!(:item) { create(:item, vendor: amazon) }

  before { login_admin }

  describe "GET#index" do
    it "it displays all vendors" do
      get :index

      expect(assigns[:vendors]).to eq (Vendor.all)
      expect(response).to be_success
    end
  end

  describe "GET#show" do
    it "displays the items" do
      get :show, id: amazon.id

    expect(assigns[:vendor]).to eq (amazon)
    expect(assigns[:items]).to include (item)
    end
  end

  describe "GET#new" do
    it "shows a form" do
      get :new, id: amazon.id
    expect(response).to render_template :new
    end
  end

  describe "GET#edit" do
    it "shows a form" do
      get :edit, id: amazon.id
    expect(response).to render_template :edit
    end
  end

  describe "PATCH#update" do
    it "shows a form" do
      get :update, id: amazon.id, vendor: { name: "Google" }
    expect(response).to be_redirect
    expect(assigns(:vendor)).to be_a(Vendor)
    expect(assigns(:vendor).name).to eq("Google")
    end
  end

  describe "POST#create" do
    context "with valid params" do
      before do
        @vendor_params = { name: "Ships", status: "Active" }
      end
      it "creates a new vendor" do
        post :create, vendor: @vendor_params, next: new_item_path
      expect(response).to redirect_to new_item_path
      end

      it "creates a new vendor" do
        post :create, vendor: @vendor_params, next: vendors_path
      expect(response).to redirect_to vendors_path
      expect(flash[:notice]).to eq "Vendor was successfully created"
      expect(assigns(:vendor).status).to eq("Active")
      end
    end
  end
end
