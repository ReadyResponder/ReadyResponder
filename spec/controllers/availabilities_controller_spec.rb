require 'rails_helper'

RSpec.describe AvailabilitiesController, type: :controller do

  before(:each) { login_admin }

  describe 'GET new' do
    it 'assigns @availability' do
      get :new
      expect(assigns(:availability)).not_to be_nil
    end

    it 'assigns @people_collection' do
      get :new
      expect(assigns(:people_collection)).not_to be_nil
    end

    context 'for an existing event' do
      let(:event) { create(:event) }

      it 'sets up @availability with the start and end dates of the event' do
        get :new, params: { event_id: event.id }
        expect(assigns(:availability).start_time).to be_within(1.second).of(event.start_time)
        expect(assigns(:availability).end_time).to be_within(1.second).of(event.end_time)
      end
    end

    context 'for an existing person' do
      let(:person) { create(:person) }

      it 'sets up @availability with the person' do
        get :new, params: { person_id: person.id }
        expect(assigns(:availability).person).to eq(person)
      end
    end
  end

  describe 'GET edit' do
    let(:person)       { create(:person) }
    let(:availability) { create(:availability, person: person) }

    it 'assigns @availability' do
      get :edit, params: { person_id: person.id, id: availability.id }
      expect(assigns(:availability)).not_to be_nil
    end

    describe '@people_collection' do
      it 'is assigned' do
        get :edit, params: { id: availability.id }
        expect(assigns(:people_collection)).not_to be_nil
      end

      it 'includes the person that is part of the @availability' do
        get :edit, params: { id: availability.id }
        expect(assigns(:people_collection)).to include(availability.person)
      end
    end

    context 'on an inactive person' do
      let(:person) { create(:inactive_person) }

      it 'sets up @people_collection including the person' do
        get :edit, params: { id: availability.id }
        expect(assigns(:people_collection)).to include(availability.person)
      end
    end
  end

  describe 'PATCH update' do
    let(:av_person_inactive)       { create(:inactive_person, :firstname => 'Alex') }
    let(:availability) { create(:availability, person: av_person_inactive) }
    let(:active_person)       { create(:person, :firstname => 'Bane') }
    let(:inactive_person) { create(:inactive_person) }
    start_time = Time.now.strftime('%Y-%m-%d %H:%M')
    end_time = 1.days.from_now.strftime('%Y-%m-%d %H:%M')
    let!(:availability_params) do
      {:person_id => active_person.id, :status => "Available", :description => "Meeting", :start_time => start_time, :end_time => end_time}
    end

    context 'success' do
      it 'updates all attributes and redirects to show' do
        patch :update, params: { availability: availability_params, id: availability.id }

        expect(assigns(:availability)).to eq(availability)
        expect(response).to redirect_to(availability_path(availability))
        expect(flash[:notice]).to eq('Availability was successfully updated.')

        availability.reload
        availability_params.each do |key, value|
          actual_val = [:start_time, :end_time].include?(key) ? availability.send(key).strftime('%Y-%m-%d %H:%M') : availability.send(key)
          expect(actual_val).to eq(value), "Should update #{key} to #{value}"
        end
      end
    end

    context 'with errors' do
      let(:invalid_availability_params) do
        availability_params.tap do |params|
          params[:start_time] = end_time
          params[:end_time] = start_time
        end
      end

      it 'does not updates and renders edit with correct assignments' do
        patch :update, params: { availability: invalid_availability_params, id: availability.id}

        expect(assigns(:availability)).to eq(availability)
        expect(assigns(:people_collection)).to eq([av_person_inactive, active_person]), "Should set only active persons, except person belonging to the availability, sorted by name"
        expect(response).to render_template(:edit)

        availability.reload
        availability_params.each do |key, value|
          actual_val = [:start_time, :end_time].include?(key) ? availability.send(key).strftime('%Y-%m-%d %H:%M') : availability.send(key)
          expect(actual_val).not_to eq(value), "Should not update #{key}"
        end
      end
    end
  end

end
