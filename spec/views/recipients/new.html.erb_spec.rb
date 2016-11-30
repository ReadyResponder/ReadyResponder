require 'rails_helper'

RSpec.describe "recipients/new", type: :view do
  before(:each) do
    assign(:recipient, Recipient.new())
  end

  it "renders new recipient form" do
    render

    assert_select "form[action=?][method=?]", recipients_path, "post" do
    end
  end
end
