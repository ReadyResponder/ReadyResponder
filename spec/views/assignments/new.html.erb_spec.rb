require 'rails_helper'

RSpec.describe "assignments/new", type: :view do
  before(:each) do
    @cj = create(:person, firstname: 'CJ', lastname: 'Doe' )
    assign(:assignment, Assignment.new(
      :person => @cj,
      :requirement => nil,
      :status => "New",
      :duration => "9.99"
    ))
  end

  it "renders new assignment form" do
    render

    assert_select "form[action=?][method=?]", assignments_path, "post" do
      assert_select "select#assignment_person_id[name=?]", "assignment[person_id]"

      assert_select "input#assignment_status[name=?]", "assignment[status]"

      assert_select "input#assignment_duration[name=?]", "assignment[duration]"
    end
  end
end
