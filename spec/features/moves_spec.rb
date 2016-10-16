require 'rails_helper'

RSpec.describe "Moves" do
  before(:each) { sign_in_as('Editor') }

  get_basic_editor_views('move',['reason'])
end
