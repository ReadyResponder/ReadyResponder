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

  describe 'titled?' do
    it 'should return true if the person has the title' do
      title = build(:title)
      person = build(:person, titles: [title])
      expect(person.titled?(title)).to be true
    end
    it "should return false if the person doesn't have the title" do
      title = build(:title)
      person = build(:person, titles: [])
      expect(person.titled?(title)).to be false
    end
    it "should return false if a nil title is passed in" do
      title = build(:title)
      person = build(:person, titles: [title])
      expect(person.titled?(nil)).to be false
    end
  end
  describe 'skilled?' do
    it 'should work with the name of the skill' do
      person = build(:person)
      skill1 = create(:skill)
      allow(person).to(receive(:skills).and_return([skill1]))
      expect(person.skilled?(skill1.name)).to be true
    end
    it 'should return true if the person has the skill' do
      person = build(:person)
      skill1 = create(:skill)
      skill2 = create(:skill)
      allow(person).to(receive(:skills).and_return([skill1, skill2]))
      expect(person.skilled?(skill2)).to be true
    end
    it "should return false if the person has only different skills" do
      person = build(:person)
      skill1 = create(:skill)
      skill2 = create(:skill)
      allow(person).to(receive(:skills).and_return([skill1]))
      expect(person.skilled?(skill2)).to be false

    end
    it "should return false if the person has no skills" do
      person = build(:person)
      skill2 = create(:skill)
      expect(person.skilled?(skill2)).to be false
    end
    it "should return false if the skill passed in is nil" do
      person = build(:person)
      expect(person.skilled?(nil)).to be false
    end
    it "should return false if the skill passed in is empty string" do
      person = build(:person)
      expect(person.skilled?('')).to be false
    end
  end
  describe 'qualified?' do
    it 'should work with the name of the title' do
      title = create(:title)
      person = build(:person, titles: [title])
      expect(person.qualified?(title.name)).to be true

    end
    it "should return false if they already have the title but not skills" do
      skill1 = create(:skill)
      skill2 = create(:skill)
      title = create(:title, skills: [skill1, skill2])
      person = build(:person, titles: [title])
      expect(person.qualified?(title)).to be false
    end
    it "should return true if they have all the skills for the title" do
      person = build(:person)
      skill1 = create(:skill)
      skill2 = create(:skill)
      title = create(:title, skills: [skill1, skill2])
      allow(person).to(receive(:skills).and_return([skill1, skill2]))
      expect(person.qualified?(title)).to be true
    end
    it "should return false if they don't have all the skills for the title" do
      person = build(:person)
      skill1 = create(:skill)
      skill2 = create(:skill)
      title = create(:title, skills: [skill1, skill2])
      allow(person).to(receive(:skills).and_return([skill1]))
      expect(person.qualified?(title)).to be false

    end
    it "should return false if the title passed in is nil" do
      person = build(:person)
      expect(person.qualified?(nil)).to be false
    end
    it "should return false if the title passed in is empty string" do
      person = build(:person)
      expect(person.qualified?('')).to be false
    end
  end
  describe 'titled_and_qualified?' do
    it 'should return true if you are titled and qualified' do
      person = build(:person)
      title = build(:title)
      allow(person).to(receive(:titled?).and_return(true))
      allow(person).to(receive(:qualified?).and_return(true))
      expect(person.titled_and_qualified?(title)).to be true
    end
    it 'should return false if you are titled but not qualified' do
      person = build(:person)
      title = build(:title)
      allow(person).to(receive(:titled?).and_return(true))
      allow(person).to(receive(:qualified?).and_return(false))
      expect(person.titled_and_qualified?(title)).to be false

    end
    it 'should return false if you are qualified but not titled' do
      person = build(:person)
      title = build(:title)
      allow(person).to(receive(:titled?).and_return(false))
      allow(person).to(receive(:qualified?).and_return(true))
      expect(person.titled_and_qualified?(title)).to be false

    end
  end
  describe 'has_any_of_title_or_skills?' do
    it "returns true if the person has a matching title" do
      title = create(:title)
      person = build(:person, titles: [title])
      expect(person.has_any_of_titles_or_skills?([title])).to be true
    end
    it "returns true if the person has a matching skill" do
      person = build(:person)
      skill = create(:skill)
      allow(person).to(receive(:skills).and_return([skill]))
      expect(person.has_any_of_titles_or_skills?([skill])).to be true
    end

    it "returns false if the person has no matching title or skill" do
      person = build(:person)
      skill = create(:skill)
      title = create(:title)
      expect(person.has_any_of_titles_or_skills?([skill, title])).to be false

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
