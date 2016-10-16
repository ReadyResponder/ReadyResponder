require 'rails_helper'

RSpec.describe "Channels" do
  before(:each) { sign_in_as('Editor') }

  get_basic_editor_views('channel',['category'])
end
