require 'rails_helper'

RSpec.describe Person do
  describe 'validations' do
    it { is_expected.to validate_length_of(:state).is_equal_to 2 }
    it { is_expected.to validate_uniqueness_of(:icsid) }

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

    it "requires end_date to be after start_date" do # chronology
      @person = build(:person, start_date: 2.days.from_now, end_date: 2.days.ago)
      expect(@person).not_to be_valid
    end
  end

  describe 'date_last for availability' do
    let!(:employee) {create :person}
    let!(:early_available) { create :availability, person: employee,
                             start_time: 300.hours.ago, end_time: 290.hours.ago,
                             status: 'Available' }
    let!(:recent_available) { create :availability, person: employee,
                            start_time: 24.hours.ago, end_time: 16.hours.ago,
                            status: 'Available' }
    let!(:recent_unavailable) { create :availability, person: employee,
                             start_time: 19.hours.ago, end_time: 16.hours.ago,
                             status: 'Unavailable' }
    it 'finds the correct date_last_responded' do
      expect(employee.date_last_responded).to be_within(1.second).of recent_unavailable.start_time
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
end
