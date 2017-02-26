require 'rails_helper'

RSpec.describe "assignments/show", type: :view do
  before(:each) do
    @assignment = assign(:assignment, Assignment.create!(
      :person => nil,
      :requirement => nil,
      :status => "Status",
      :duration => "9.99"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(//)
    expect(rendered).to match(/Status/)
    expect(rendered).to match(/9.99/)
  end
end
