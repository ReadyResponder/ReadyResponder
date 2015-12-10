require 'spec_helper'

describe Person do
  describe 'validations' do
    it { is_expected.to validate_length_of(:state).is_equal_to 2 }
    it { is_expected.to validate_uniqueness_of(:icsid) }

    describe 'divisions' do
      context 'division 1 present' do
        it 'is invalid if division 2 is blank' do
          person = FactoryGirl.build :person, division2: ''
          expect(person).not_to be_valid
        end
      end

      context 'division 2 present' do
        it 'is invalid if division 1 is blank' do
          person = FactoryGirl.build :person, division1: ''
          expect(person).not_to be_valid
        end
      end
    end
  end

  describe 'skills' do
    subject { FactoryGirl.create :person }
    let(:evoc_course) { FactoryGirl.create :course, skills: [skill] }
    let(:skill) { FactoryGirl.create :skill }
    let(:cert) { FactoryGirl.create(:cert, {person: subject, course: evoc_course}.merge(cert_options)) }
    let(:cert_options) { {} }

    context 'cert' do
      context 'does not exist' do
        before(:each) { Cert.destroy_all }

        it 'does not have the skill' do
          expect(subject).not_to be_skilled skill.name
        end
      end

      context 'cert is expired' do
        let(:cert_options) { {status: 'Expired'} }

        it 'does not have the skill' do
          expect(cert.course.skills).to include skill
          expect(subject).not_to be_skilled skill.name
        end
      end

      context 'cert is not expired' do
        it 'has the skill' do
          expect(cert.course.skills).to include skill
          expect(subject).to be_skilled skill.name
        end
      end
    end

    describe 'qualification' do
      let(:title) { FactoryGirl.create :title, skills: [skill] }

      before(:each) { cert }

      context 'has skill required by title' do
        it 'is qualified for the title' do
          expect(subject).to be_skilled skill.name
          expect(subject).to be_qualified title.name
        end
      end

      context 'does not have skill required by title' do
        let(:irrelevant_skill) { FactoryGirl.create :skill }
        let(:irrelevant_course) { FactoryGirl.create :course, skills: [irrelevant_skill] }
        let(:cert_options) { {course: irrelevant_course} }

        it 'is not qualified for the title' do
          expect(subject).to be_skilled irrelevant_skill.name
          expect(subject).not_to be_qualified title.name
        end
      end
    end
  end
end
