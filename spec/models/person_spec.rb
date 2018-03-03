require 'rails_helper'

RSpec.describe Person do
  describe 'validations' do
    it { is_expected.to validate_length_of(:state).is_equal_to 2 }
    it { is_expected.to validate_uniqueness_of(:icsid) }
    it { is_expected.to have_many(:inspectors) }
    it { is_expected.to validate_presence_of(:department) }

    describe 'divisions' do
      context 'division 1 present' do
        it 'is invalid if division 2 is blank' do
          person = build :person, division2: ''
          expect(person).not_to be_valid
        end
      end

      context 'division 2 present' do
        it 'is invalid if division 1 is blank' do
          person = build :person, division1: ''
          expect(person).not_to be_valid
        end
      end
    end

    it "zipcode must be 5 digits" do
      person1 = build(:person, zipcode: "abcde")
      person2 = build(:person, zipcode: "1234")
      person3 = build(:person, zipcode: "#2827c")
      person4 = build(:person, zipcode: "12345")
      person5 = build(:person, zipcode: "12345-1234")
      expect(person1).not_to be_valid
      expect(person2).not_to be_valid
      expect(person3).not_to be_valid
      expect(person4).to be_valid
      expect(person5).to be_valid
    end

    it "requires end_date to be after start_date" do # chronology
      person = build(:person, start_date: 2.days.from_now, end_date: 2.days.ago)
      expect(person).not_to be_valid
    end

    describe "application_date_cannot_be_before_start_date" do
      let(:person) { build :person, start_date: start_date, application_date: application_date }

      context "when the start date is not present" do
        let!(:application_date) { Time.zone.today }
        let!(:start_date) { nil }

        it "is a valid person" do
          expect(person).to be_valid
        end
      end

      context "when the application date is not present" do
        let!(:application_date) { nil }
        let!(:start_date) { Time.zone.today }

        it "is a valid person" do
          expect(person).to be_valid
        end
      end

      context "when the application date and start date are the same" do
        let!(:application_date) { Time.zone.today }
        let!(:start_date) { Time.zone.today }

        it "is a valid person" do
          expect(person).to be_valid
        end
      end

      context "when the start date is before the application date" do
        let!(:application_date) { Time.zone.today }
        let!(:start_date) { Time.zone.yesterday }

        it "is not a valid person" do
          expect(person).to_not be_valid
        end
      end
    end
  end

  describe 'date_last for availability' do
    let!(:employee) {create :person}
    let!(:early_available) { create :availability, person: employee,
                             start_time: 300.hours.ago, end_time: 290.hours.ago,
                             status: 'Available' }
    let!(:recent_available) { create :availability, person: employee,
                            start_time: 48.hours.ago, end_time: 24.hours.ago,
                            status: 'Available' }
    let!(:recent_unavailable) { create :availability, person: employee,
                             start_time: 19.hours.ago, end_time: 16.hours.ago,
                             status: 'Unavailable' }
    it 'finds the correct date_last_responded' do
      expect(employee.date_last_responded).to be_within(1.second).of recent_unavailable.created_at
    end
    it 'finds the correct date_last_available' do
      expect(employee.date_last_available).to be_within(1.second).of recent_available.start_time
    end
  end

  describe 'date_last for timecards' do
    let!(:employee) {create :person}
    let!(:early_timecard) { create :timecard, person: employee,
                          start_time: 250.hours.ago, end_time: 225.hours.ago,
                          status: 'Verified'}
    let!(:recent_timecard) { create :timecard, person: employee,
                          start_time: 16.hours.ago, end_time: 8.hours.ago,
                          status: 'Verified'}
    let!(:unverified_timecard) { create :timecard, person: employee,
                          start_time: 2.hours.ago, end_time: 1.hours.ago,
                          status: 'Unverified'}
    it 'finds the correct date_last_worked' do
      expect(employee.date_last_worked).to be_within(1.second).of recent_timecard.start_time
    end
  end

  describe 'skills' do
    subject { create :person }
    let(:evoc_course) { create :course, skills: [skill] }
    let(:skill) { create :skill }
    let(:cert) { create(:cert, {person: subject, course: evoc_course}.merge(cert_options)) }
    let(:cert_options) { {} }

    context 'cert' do
      context 'does not exist' do
        before(:each) { Cert.destroy_all }

        it 'does not have the skill' do
          expect(subject).not_to be_skilled skill.name
        end
      end

      context 'expired' do
        let(:cert_options) { {status: 'Expired'} }

        it 'does not have the skill' do
          expect(cert.course.skills).to include skill
          expect(subject).not_to be_skilled skill.name
        end
      end

      context 'not expired' do
        it 'has the skill' do
          expect(cert.course.skills).to include skill
          expect(subject).to be_skilled skill.name
        end
      end
    end

    describe 'qualification' do
      let(:title) { create :title, skills: [skill] }

      before(:each) { cert }

      context 'has skill required by title' do
        it 'is qualified for the title' do
          expect(subject).to be_skilled skill.name
          expect(subject).to be_qualified title.name
        end
      end

      context 'does not have skill required by title' do
        let(:irrelevant_skill) { create :skill }
        let(:irrelevant_course) { create :course, skills: [irrelevant_skill] }
        let(:cert_options) { {course: irrelevant_course} }

        it 'is not qualified for the title' do
          expect(subject).to be_skilled irrelevant_skill.name
          expect(subject).not_to be_qualified title.name
        end
      end
    end
  end

  describe 'meeting requirement' do
    let(:title) { create :title }
    let(:requirement) { build :requirement, title: title }

    context 'has title of requirement' do 
      let(:person) { create :person, titles: [title] }
      it 'meets the requirement' do
        expect(person.meets?(requirement)).to be true
      end
    end
  end
  describe 'associations' do
    it { is_expected.to have_many(:comments) }
  end

  describe 'sort' do
    it 'sorts based on first_name, last_name and middleinitial accordingly' do
      person1 = create(:person, firstname: 'Baily', lastname: 'joss') #6   
      person2 = create(:person, firstname: 'AAA', lastname: 'Amose') #1
      person3 = create(:person, firstname: 'Alex', lastname: 'Bane', middleinitial: 'Andy') #4
      person4 = create(:person, firstname: 'Alex', lastname: 'Bane', middleinitial: 'Bndy') #5
      person5 = create(:person, firstname: 'Agon', lastname: 'Jane', middleinitial: 'Sndy') #3
      person6 = create(:person, firstname: 'aaon', lastname: 'Amose', middleinitial: 'Mndy') #2
      
      expect(Person.all.sort).to eq([person2, person6, person5, person3, person4, person1])
    end
  end

  context 'titled_equal_or_higher_than scope' do
    it 'returns a chainable relation' do
      expect(described_class.titled_equal_or_higher_than('a title'))
        .to be_a_kind_of(ActiveRecord::Relation)
    end

    context 'given 3 people with different titles' do
      let!(:person_1) { create(:person, title_order: 1) }
      let!(:person_2) { create(:person, title_order: 2) }
      let!(:person_3) { create(:person, title_order: 3) }

      let(:title_order) { { 'title a' => 1, 'title b' => 2,
                            'title c' => 3, 'title d' => 4 } }
      let(:default_title_order) { 5 }

      it 'returns the ones titled higher than or equal to the given title' do
        stub_const('Person::TITLE_ORDER', title_order)
        expect(described_class.titled_equal_or_higher_than('title b'))
          .to contain_exactly(person_1, person_2)
      end

      it 'returns all people titled higher than the default title order '\
         'when an invalid title is given' do
        stub_const('Person::DEFAULT_TITLE_ORDER', default_title_order)
        expect(described_class.titled_equal_or_higher_than('no title'))
          .to contain_exactly(person_1, person_2, person_3)
      end
    end
  end

  describe 'upcoming_events' do
    let(:department) { create :department }
    let(:person) { create :person, department: department }
    let(:e1) { create :event, departments: [department] }
    let(:e2) { create :event, departments: [department] }
    let(:e3) { create :event, departments: [department] }
    let(:e4) { create :event, departments: [department] }
    let(:e5) { create :event, departments: [department] }
    let(:e6) { create :event, departments: [department] }
    let(:e7) { create :event, departments: [department] }
    let(:e8) { create :event, departments: [department] }
    let(:e9) { create :event, departments: [department] }
    let(:e10) { create :event, departments: [department] }    
    Setting.where(:key => 'UPCOMING_EVENTS_COUNT').destroy_all
    let(:setting) { Setting.find_or_create_by(:key => 'UPCOMING_EVENTS_COUNT', :value => 5, :category => 'Person', :status => 'Active', :name => 'upcoming_events_count') }

    context 'with settings' do    
      it 'returns count from setting' do        
        expect(person.upcoming_events).to eq [e6, e7, e8, e9, e10]        
      end
    end

    context 'without settings' do
      it 'uses fallback value when setting is not available' do        
        setting.destroy
        expect(person.upcoming_events).to eq [e1, e2, e3, e4, e5, e6, e7, e8, e9, e10]        
      end
      it 'returns fallback value when setting is inactive' do
        setting.update_attribute(:status, 'Inactive')
        expect(person.upcoming_events).to eq [e1, e2, e3, e4, e5, e6, e7, e8, e9, e10]        
      end            
    end
  end
end
