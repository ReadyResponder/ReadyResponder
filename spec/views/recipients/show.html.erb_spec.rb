require 'rails_helper'

RSpec.describe "recipients/show", type: :view do
  before(:each) do
    @recipient = assign(:recipient, Recipient.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
