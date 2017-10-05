require 'rails_helper'

RSpec.describe InspectionsController, type: :controller do
  let!(:inspections) { create_list(:inspection, 3) }
  let(:inspection) { inspections.first }
  let(:item) { inspection.item }

  before { login_manager }

  describe '#index' do
    it 'assigns inspections & renders' do
      get :index

      expect(assigns[:inspections]).to eq(Inspection.all)
      expect(response).to be_success
    end
  end

  describe '#show' do
    it 'assigns an inspection & renders' do
      get :show, id: inspection.id

      expect(assigns[:inspection]).to eq(inspection)
      expect(response).to be_success
    end
  end

  describe '#new' do
    let(:item) { inspections.first.item }

    subject { get :new, item_id: item.id }

    before { subject }

    it 'sets the item' do
      expect(assigns[:item]).to eq(item)
    end

    it 'builds a new inspection for an item & renders' do
      expect(assigns[:inspection]).to have_attributes(item_id: item.id)
      expect(response).to be_success
    end
  end

  describe '#edit' do
    it 'assigns an inspection & renders' do
      get :show, id: inspection.id

      expect(assigns[:inspection]).to eq(inspection)
      expect(response).to be_success
    end
  end

  describe '#create' do
    let(:item) { inspections.first.item }
    let(:inspection_params) do
      {
        item_id: item.id,
        inspection: { inspection_date: Time.now, status: 'Passed' }
      }
    end

    subject { post :create, inspection_params }

    context 'with a successful save' do
      it 'creates a new inspection' do
        expect { subject }.to change { Inspection.count }.by(1)
      end

      it 'flashes a notice & redirects' do
        subject

        expect(flash[:notice]).to eq('Inspection was successfully created.')
        expect(response).to redirect_to(item_path(item))
      end
    end

    context 'with errors' do
      let(:invalid_inspection_params) do
        inspection_params.tap do |params|
          params[:inspection][:inspection_date] = nil
        end
      end

      subject { post :create, invalid_inspection_params }

      it "doesn't create a new inspection" do
        expect { subject }.to_not change { Inspection.count }
      end

      it 'renders' do
        subject

        expect(response).to render_template(:new)
      end
    end
  end

  describe '#update' do
    let(:inspection_params) do
      {
        id: inspection.id,
        inspection: { inspection_date: Time.now, status: 'Incomplete' }
      }
    end

    subject { put :update, inspection_params }

    context 'with a successful update' do
      it 'updates the inspection' do
        expect { subject }.to change { inspection.reload.status }.from('Passed').to('Incomplete')
      end

      it 'flashes a notice & redirects' do
        subject

        expect(flash[:notice]).to eq('Inspection was successfully updated.')
        expect(response).to redirect_to(item_path(item))
      end
    end

    context 'with errors' do
      let(:invalid_inspection_params) do
        inspection_params.tap do |params|
          params[:inspection][:inspection_date] = nil
        end
      end

      subject { put :update, invalid_inspection_params }

      it "doesn't create a new inspection" do
        expect { subject }.to_not change { inspection.status }
      end

      it 'renders' do
        subject

        expect(response).to render_template(:edit)
      end
    end
  end

  describe '#destroy' do
    subject { delete :destroy, id: inspection.id }

    it 'deletes an inspection' do
      subject

      expect { inspection.reload }.to raise_error(ActiveRecord::RecordNotFound)
      expect(response).to redirect_to(inspections_url)
    end
  end
end
