require 'rails_helper'

RSpec.describe InspectionsController, type: :controller do
  let(:active_person) { create(:person, firstname: 'Aaon' ) }
  let(:inactive_person) { create(:inactive_person, firstname: 'Aaby' ) }
  let(:item) { create(:item) }
  let!(:inspections) { create_list(:inspection, 3, item_id: item.id) }
  let(:inspection) { inspections.first }

  before { login_manager }

  describe '#index' do
    it 'assigns inspections & renders' do
      get :index

      expect(assigns[:inspections]).to eq(Inspection.all)
      expect(response).to be_successful
    end
  end

  describe '#show' do
    it 'assigns an inspection & renders' do
      get :show, params: { id: inspection.id }

      expect(assigns[:inspection]).to eq(inspection)
      expect(response).to be_successful
    end
  end

  describe '#new' do
    subject { get :new, params: { item_id: item.id } }

    before {
      active_person
      inactive_person
      subject }

    it 'sets the item and inspectors' do
      expect(assigns[:item]).to eq(item)
      expect(assigns[:inspectors]).to eq([active_person, item.owner]), "Should assign only active persons as inspectors"
    end

    it 'builds a new inspection for an item & renders' do
      expect(assigns[:inspection]).to have_attributes(item_id: item.id)
      expect(response).to be_successful
    end
  end

  describe '#edit' do
    it 'assigns an inspection & renders' do
      active_person
      inspection.update_attribute(:person_id, inactive_person.id)
      get :edit, params: { id: inspection.id }

      expect(assigns[:inspection]).to eq(inspection)
      expect(assigns[:inspectors]).to eq([inactive_person, active_person, item.owner])
      expect(response).to be_successful
    end
  end

  describe '#create' do
    let!(:inspection_params) do
      {
        item_id: item.id,
        inspection: { inspection_date: Time.now.strftime('%Y-%m-%d %H:%M'), status: 'Passed' }
      }
    end

    subject { post :create, params: inspection_params }

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

      subject { post :create, params: invalid_inspection_params }

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
        inspection: { inspection_date: Time.now.strftime('%Y-%m-%d %H:%M'), status: 'Incomplete' }
      }
    end

    subject { put :update, params: inspection_params }

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

      subject { put :update, params: invalid_inspection_params }

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
    subject { delete :destroy, params: { id: inspection.id } }

    it 'deletes an inspection' do
      subject

      expect { inspection.reload }.to raise_error(ActiveRecord::RecordNotFound)
      expect(response).to redirect_to(inspections_url)
    end
  end
end
