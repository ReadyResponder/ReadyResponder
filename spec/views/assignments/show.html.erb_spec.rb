require 'rails_helper'

RSpec.describe "assignments/show", type: :view do
  let(:user) { FactoryGirl.create :user }
  let(:task) { create :task }
  let (:skill) { create :skill }

  let (:event) { create(:event) }
  let(:task) { create(:task, event: event) }
  let(:cj) { create(:person, firstname: 'CJ', lastname: 'Doe' ) }

  before(:each) do
    @requirement = create(:requirement, task: task, skill: skill)
    @assignment = @requirement.assignments.new(
      :person => cj,
      :status => "New",
      :duration => "9.99"
    )

    allow(controller).to receive(:current_user).and_return(user)
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Doe/)
    expect(rendered).to match(//)
    expect(rendered).to match(/Status/)
    expect(rendered).to match(/9.99/)
  end
end
