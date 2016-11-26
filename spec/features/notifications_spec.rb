require 'rails_helper'

RSpec.describe "Notifications" do
  describe " visit notifications" do
    before (:each) { sign_in_as('Editor') }

    get_basic_editor_views('notification',['status','subject'])
  end
end
