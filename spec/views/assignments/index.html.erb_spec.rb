require 'rails_helper'

RSpec.describe "assignments/index", type: :view do
  before(:each) do
    @cj = create(:person, firstname: 'CJ', lastname: 'Doe' )

    assign(:assignments, [
      Assignment.create!(
        :person => @cj,
        :requirement => nil,
        :status => "Notified",
        :duration => "9.99"
      ),
      Assignment.create!(
        :person => @cj,
        :requirement => nil,
        :status => "Notified",
        :duration => "9.99"
      )
    ])
  end

  it "renders a list of assignments" do
    render
    assert_select "tr>td", :text => @cj.to_s, :count => 2
    assert_select "tr>td", :text => @cj.to_s, :count => 2
    assert_select "tr>td", :text => "Notified".to_s, :count => 2
    assert_select "tr>td", :text => "9.99".to_s, :count => 2
  end
end
