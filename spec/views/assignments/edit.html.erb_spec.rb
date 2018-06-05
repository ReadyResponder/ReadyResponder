require 'rails_helper'

RSpec.describe "assignments/edit", type: :view do
  before(:each) do
    @cj = create(:person, firstname: 'CJ', lastname: 'Doe' )
    @requirement = assign(:requirement, Requirement.new)
    @assignment = assign(:assignment, Assignment.create!(
      :person => @cj,
      :requirement => nil,
      :status => "New",
      :duration => "9.99",
      :start_time => "2017-02-26 11:41:15",
      :end_time => "2017-02-26 11:41:15"
    ))
  end

  it "renders the edit assignment form" do
    allow(@requirement).to receive(:task).and_return(Task.new)
    allow(@requirement).to receive(:event).and_return(Event.new)

    allow(@requirement).to receive(:id).and_return(1)
    allow(@assignment).to receive(:requirement).and_return(@requirement)
    render

    assert_select "select#assignment_person_id[name=?]", "assignment[person_id]"
    assert_select "input#assignment_start_time[name=?]", "assignment[start_time]"
    assert_select "input#assignment_end_time[name=?]", "assignment[end_time]"
  end
end
