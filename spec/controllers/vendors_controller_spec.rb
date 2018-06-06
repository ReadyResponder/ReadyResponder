require 'rails_helper'

RSpec.describe VendorsController, type: :controller do
  let!(:amazon) { create(:vendor) }
  let!(:item) { create(:item, vendor: amazon) }
  let(:valid) do
    {
      name: "Ships",
      status: "Active"
    }
  end

  let(:invalid) do
    {
      status: "Active"
    }
  end
  before { login_admin }

  describe "GET#index" do
    it "it displays all vendors" do
      get :index

      expect(assigns[:vendors]).to eq(Vendor.all)
      expect(Vendor.count).to eq(1)
      expect(response).to be_success
    end
  end

  describe "GET#show" do
    it "displays the items" do
      get :show, id: amazon.id

      expect(assigns[:vendor]).to eq(amazon)
      expect(assigns[:items]).to include(item)
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
    context "with valid params" do
      it "successfully updates" do
        get :update, id: amazon.id, vendor: { name: "Google" }

        vendor = assigns(:vendor)
        expect(response).to be_redirect
        expect(vendor).to be_a(Vendor)
        expect(vendor.name).to eq("Google")
        expect(Vendor.count).to eq(1)
      end
    end

    context "with invalid params" do
      it "rendors an error message" do
        microsoft = create(:vendor, name: "microsoft")
        get :update, id: amazon.id, vendor: { name: "microsoft" }

        expect(flash[:alert]).to eq("Name has already been taken")
        expect(Vendor.count).to eq(2)
      end
    end
  end

  describe "POST#create" do
    context "with valid params" do
      it "creates a new vendor" do
        post :create, vendor: valid, next: new_item_path

        expect(response).to redirect_to new_item_path
        expect(Vendor.count).to eq(2)
      end

      it "creates a new vendor" do
        post :create, vendor: valid, next: vendors_path

        expect(response).to redirect_to vendors_path
        expect(flash[:notice]).to eq("Vendor was successfully created")
        expect(assigns(:vendor).status).to eq("Active")
        expect(Vendor.count).to eq(2)
      end
    end
  end

  context "with invalid params" do
    it "rendors an error" do
      post :create, vendor: invalid, next: new_item_path

      expect(response).to render_template :new
      expect(flash[:alert]).to eq("Name can't be blank")
      expect(Vendor.count).to eq(1)
    end

    it "creates a new vendor" do
      post :create, vendor: invalid, next: vendors_path

      expect(response).to render_template :new
      expect(flash[:alert]).to eq("Name can't be blank")
      expect(Vendor.count).to eq(1)
    end
  end
end
