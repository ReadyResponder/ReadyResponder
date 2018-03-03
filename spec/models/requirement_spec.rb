require 'rails_helper'

RSpec.describe Requirement, type: :model do
  let(:an_event) { build(:event) }
  let(:a_task) { build(:task, event: an_event) }
  let(:a_skill) { build_stubbed(:skill) }
  let(:a_title) { build_stubbed(:title) }
  it "has a valid factory" do
    # expect(build_stubbed(:requirement)).to be_valid
    expect(build_stubbed(:requirement, task: a_task, skill: a_skill)).to be_valid
    expect(build_stubbed(:requirement, task: a_task, title: a_title)).to be_valid
    expect(build_stubbed(:requirement, task: a_task, title: a_title,
                         skill: a_skill)).to_not be_valid
  end

  context 'assignable?' do
    # person->certs->courses->skills
    let!(:person)  { create(:person) }
    let!(:skill_1) { create(:skill) }
    let!(:course_1){ create(:course,  skills: [skill_1]) }
    let!(:cert_1)  { create(:cert, course: course_1) }
    context '(when people are needed)' do
      it "should return true when person has matching skill" do
        req = build(:requirement, task: a_task, skill: skill_1)
        person.certs << cert_1
        expect(req.assignable?(person)).to(eq(true))
      end
      it "should return true when person has matching title" do
        req = build(:requirement, task: a_task, title: a_title)
        p = build(:person, titles: [a_title])
        expect(req.assignable?(p)).to(eq(true))
      end
      it "should return false when the person is already assigned" do
        req = create(:requirement, task: a_task, skill: skill_1, maximum_people: 5)
        person.certs.push(cert_1)
        ass = create(:assignment, person: person, requirement: req)
        req.assignments << ass
        expect(req.assignable?(person)).to(eq(false))
      end
    end

    context '(when people are not needed)' do
      it "should return false for people with matching skills" do
        req = create(:requirement, task: a_task, skill: skill_1)
        person.certs << cert_1
        ass = create(:assignment, person: person, requirement: req)
        req.assignments << ass
        expect(req.assignable?(person)).to(eq(false))
      end
      it "should return false for people with matching titles" do
        req = build(:requirement, task: a_task, title: a_title)
        person.certs.push(cert_1)
        ass = build(:assignment, person: person, requirement: req)
        req.assignments.push(ass)
        expect(req.assignable?(person)).to(eq(false))
      end
    end
  end
  context 'validations' do
    it { should belong_to(:task) }
    it { should validate_presence_of(:task) }

    it { should belong_to(:skill) }
    it { should belong_to(:title) }

    context "if it doesn't have a title" do
      before { allow(subject).to receive(:title).and_return(nil) }
      it { should validate_presence_of(:skill).with_message(/must have/) }
    end

    context "if it doesn't have a skill" do
      before { allow(subject).to receive(:skill).and_return(nil) }
      it { should validate_presence_of(:title).with_message(/must have/) }
    end

    it { should validate_presence_of(:minimum_people) }
    it { should validate_numericality_of(:minimum_people).only_integer.is_greater_than_or_equal_to(0) }

    it { should validate_presence_of(:maximum_people) }
    it { should validate_numericality_of(:maximum_people).only_integer.is_greater_than_or_equal_to(0) }

    it { should validate_presence_of(:desired_people) }
    it { should validate_numericality_of(:desired_people).only_integer.is_greater_than_or_equal_to(0) }

    context 'numerical validations' do
      let(:minimum_people) { 2 }
      let(:desired_people) { 4 }
      let(:maximum_people) { 4 }
      let(:bad_low_desired_people) { 1 }
      let(:bad_high_desired_people) { 5 }
      let(:bad_maximum_people) { 1 }

      it "should require that minimum_people <= desired_people <= maximum_people" do
        expect(build_stubbed(:requirement,
                             task: a_task,
                             skill: a_skill,
                             minimum_people: minimum_people,
                             desired_people: desired_people,
                             maximum_people: maximum_people)).to be_valid
        expect(build_stubbed(:requirement,
                             task: a_task,
                             skill: a_skill,
                             minimum_people: minimum_people,
                             desired_people: desired_people,
                             maximum_people: bad_maximum_people)).not_to be_valid
        expect(build_stubbed(:requirement,
                             task: a_task,
                             skill: a_skill,
                             minimum_people: minimum_people,
                             desired_people: bad_low_desired_people,
                             maximum_people: maximum_people)).not_to be_valid
        expect(build_stubbed(:requirement,
                             task: a_task,
                             skill: a_skill,
                             minimum_people: minimum_people,
                             desired_people: bad_high_desired_people,
                             maximum_people: maximum_people)).not_to be_valid
      end
    end
  end
end
