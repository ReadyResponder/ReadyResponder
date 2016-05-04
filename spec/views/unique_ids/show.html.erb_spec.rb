require 'rails_helper'

RSpec.describe "unique_ids/show", :type => :view do
  before(:each) do
    @unique_id = assign(:unique_id, UniqueId.create!(
      :item => nil,
      :status => "Status",
      :category => "Category",
      :value => "Value"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Status/)
    expect(rendered).to match(/Category/)
    expect(rendered).to match(/Value/)
  end
end
