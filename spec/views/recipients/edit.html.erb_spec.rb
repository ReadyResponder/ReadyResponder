require 'rails_helper'

RSpec.describe "recipients/edit", type: :view do
  before(:each) do
    @recipient = assign(:recipient, Recipient.create!())
  end

  it "renders the edit recipient form" do
    render

    assert_select "form[action=?][method=?]", recipient_path(@recipient), "post" do
    end
  end
end
