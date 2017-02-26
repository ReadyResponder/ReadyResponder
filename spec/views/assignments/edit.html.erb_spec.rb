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

      assert_select "input#assignment_status[name=?]", "assignment[status]"

      assert_select "input#assignment_duration[name=?]", "assignment[duration]"
    end
  end
end
