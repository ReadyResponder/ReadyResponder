require 'rails_helper'

RSpec.describe "settings/show", type: :view do
  before(:each) do
    @setting = assign(:setting, create(:setting))
  end

  it "renders attributes in <p>" do
    render
  end
end
