require 'rails_helper'

RSpec.describe "assignments/show", type: :view do
  let(:user) { FactoryGirl.create :user }
  let(:task) { create :task }


  before(:each) do
    @cj = create(:person, firstname: 'CJ', lastname: 'Doe' )
    @assignment = assign(:assignment, Assignment.create!(
      :person => @cj,
      :requirement => nil,
      :status => "Status",
      :duration => "9.99"
    ))
    allow(controller).to receive(:current_user).and_return(user)
    allow(@assignment).to receive(:task).and_return(task)
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Doe/)
    expect(rendered).to match(//)
    expect(rendered).to match(/Status/)
    expect(rendered).to match(/9.99/)
  end
end
