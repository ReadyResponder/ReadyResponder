require 'rails_helper'

RSpec.describe "settings/index", type: :view do
  before(:each) do
    assign(:settings, [
      create(:setting),
      create(:setting)
    ])
  end

  it "renders a list of settings" do
    render
  end
end
