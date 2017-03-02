require 'rails_helper'

RSpec.describe "assignments/index", type: :view do
  let(:user) { FactoryGirl.create :user }
  let(:task) { create :task }
  let (:skill) { create :skill }

  let (:event) { create(:event) }
  let(:task) { create(:task, event: event) }
  let(:cj) { create(:person, firstname: 'CJ', lastname: 'Doe' ) }

  before(:each) do
    @requirement = create(:requirement, task: task, skill: skill)
    @assignments = [@requirement.assignments.create(
      :person => cj,
      :status => "Notified",
      :duration => "9.99"
    )]

    allow(controller).to receive(:current_user).and_return(user)
  end

  it "renders a list of assignments" do
    render
    assert_select "tr>td", :text => cj.to_s, :count => 1
    assert_select "tr>td", :text => "Notified".to_s, :count => 1
    assert_select "tr>td", :text => "9.99".to_s, :count => 1
  end
end
