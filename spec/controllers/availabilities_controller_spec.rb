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
        get :new, { event_id: event.id }
        expect(assigns(:availability).start_time).to be_within(1.second).of(event.start_time)
        expect(assigns(:availability).end_time).to be_within(1.second).of(event.end_time)
      end
    end

    context 'for an existing person' do
      let(:person) { create(:person) }

      it 'sets up @availability with the person' do
        get :new, { person_id: person.id }
        expect(assigns(:availability).person).to eq(person)
      end
    end
  end

  describe 'GET edit' do
    let(:person)       { create(:person) }
    let(:availability) { create(:availability, person: person) }

    it 'assigns @availability' do
      get :edit, { person_id: person.id, id: availability.id }
      expect(assigns(:availability)).not_to be_nil
    end

    describe '@people_collection' do
      it 'is assigned' do
        get :edit, { person_id: person.id, id: availability.id }
        expect(assigns(:people_collection)).not_to be_nil
      end

      it 'includes the person that is part of the @availability' do
        get :edit, { person_id: person.id, id: availability.id }
        expect(assigns(:people_collection)).to include(availability.person)
      end
    end

    context 'on an inactive person' do
      let(:person) { create(:inactive_person) }

      it 'sets up @people_collection including the person' do
        get :edit, { person_id: person.id, id: availability.id }
        expect(assigns(:people_collection)).to include(availability.person)
      end
    end
  end
end
