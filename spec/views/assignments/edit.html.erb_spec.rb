require 'rails_helper'

RSpec.describe "assignments/edit", type: :view do
  before(:each) do
    @cj = create(:person, firstname: 'CJ', lastname: 'Doe' )
    @assignment = assign(:assignment, Assignment.create!(
      :person => @cj,
      :requirement => nil,
      :status => "New",
      :duration => "9.99"
    ))
  end

  it "renders the edit assignment form" do
    render

    assert_select "form[action=?][method=?]", assignment_path(@assignment), "post" do
      assert_select "select#assignment_person_id[name=?]", "assignment[person_id]"
      assert_select "input#assignment_start_time[name=?]", "assignment[start_time]"
      assert_select "input#assignment_end_time[name=?]", "assignment[end_time]"
    end
  end
end
