require 'rails_helper'

RSpec.describe "Channels" do
  before(:each) { sign_in_as('Editor') }

  get_nested_editor_views('person', 'channel',['category'])
end
