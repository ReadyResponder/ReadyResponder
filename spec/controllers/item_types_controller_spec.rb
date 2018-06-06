require 'rails_helper'

RSpec.describe ItemTypesController, type: :controller do
  let!(:item_category) { create(:item_category) }
  let!(:item_type) { create(:item_type, item_category: item_category, name: 'item1') }
  let!(:item_type2) { create(:item_type, item_category: item_category) }

  before { login_manager }

  describe '#index' do
    it 'assigns item_types & renders' do
      get :index

      expect(assigns[:item_types].sort).to eq([item_type, item_type2].sort)
      expect(response).to be_successful
    end
  end

  describe '#show' do
    it 'assigns an item_type & renders' do
      get :show, params: { id: item_type.id }

      expect(assigns[:item_type]).to eq(item_type)
      expect(response).to be_successful
    end
  end

  describe '#new' do
    context 'without item_category' do
      it 'builds a new item_type & renders' do
        get :new

        expect(assigns[:item_type]).to have_attributes(status: 'Active')
        expect(response).to be_successful
      end
    end

    context 'with item_category' do
      it 'builds a new item_type & renders' do
        get :new, params: { item_category_id: item_category.id }

        expect(assigns[:item_type]).to have_attributes(status: 'Active')
        expect(assigns[:item_type]).to have_attributes(item_category_id: item_category.id)
        expect(response).to be_successful
      end
    end

  end

  describe '#edit' do
    it 'assigns an item_type & renders' do
      get :edit, params: { id: item_type.id }

      expect(assigns[:item_type]).to eq(item_type)
      expect(response).to be_successful
    end
  end

  describe '#create' do
    let!(:item_category) {create(:item_category)}
    let!(:item_type_params) do
      {
        item_type:{
          name: 'Item type name',
          item_category_id: item_category.id,
          status: 'Inactive'
        }
      }
    end

    subject { post :create, params: item_type_params }

    context 'with a successful save' do
      it 'creates a new item_type' do
        expect { subject }.to change { ItemType.count }.by(1)
      end

      it 'flashes a notice & redirects' do
        subject

        expect(flash[:notice]).to eq('Item type was successfully created.')
        expect(response).to redirect_to(item_type_path(assigns[:item_type]))
      end
    end

    context 'with errors' do
      let!(:invalid_item_type_params) do
        {
          item_type: {item_category_id: nil}
        }
      end

      subject { post :create, params: invalid_item_type_params }

      it "doesn't create a new item_type" do
        expect { subject }.to_not change { ItemType.count }
      end

      it 'renders' do
        subject

        expect(response).to render_template(:new)
      end
    end
  end

  describe '#update' do
    let(:item_type_params) do
      {
        id: item_type.id,
        item_type: { name: 'New name'}
      }
    end

    subject { put :update, params: item_type_params }

    context 'with a successful update' do
      it 'updates the item_type' do
        expect { subject }.to change { item_type.reload.name }.from('item1').to('New name')
      end

      it 'flashes a notice & redirects' do
        subject

        expect(flash[:notice]).to eq('Item type was successfully updated.')
        expect(response).to redirect_to(item_type_path(item_type))
      end
    end

    context 'with errors' do
      let(:invalid_item_type_params) do
        item_type_params.tap do |params|
          params[:item_type][:item_category_id] = nil
          params[:item_type][:name] = 'New name'
        end
      end

      subject { put :update, params: invalid_item_type_params }

      it "doesn't create a new item_type" do
        expect { subject }.to_not change { item_type.name }
      end

      it 'renders' do
        subject

        expect(response).to render_template(:edit)
      end
    end
  end

  describe '#destroy' do
    it 'deletes an item_type' do
      delete :destroy, params: { id: item_type.id }

      expect { item_type.reload }.to raise_error(ActiveRecord::RecordNotFound)
      expect(response).to redirect_to(item_types_url)
    end
  end
end
