require 'rails_helper'

RSpec.describe "Locations" do
  describe " visit locations" do
    before (:each) { sign_in_as('Editor') }

    get_basic_editor_views('location',['name','category'])
  end
end
