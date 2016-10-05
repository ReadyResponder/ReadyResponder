require 'rails_helper'

RSpec.describe "item_types/show", :type => :view do
  before(:each) do
    @item_type = assign(:item_type, ItemType.create!(
      :name => "Name",
      :status => "Status",
      :is_groupable => "Is Groupable",
      :is_a_group => "Is A Group",
      :parent_id => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Status/)
    expect(rendered).to match(/Is Groupable/)
    expect(rendered).to match(/Is A Group/)
    expect(rendered).to match(/1/)
  end
end
