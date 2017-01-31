require 'rails_helper'

RSpec.describe "Settings" do
  describe " visit settings" do
    before (:each) { sign_in_as('Editor') }

    get_basic_editor_views('setting',['name', 'key', 'value'])
  end
end
