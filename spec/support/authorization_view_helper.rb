
module AuthorizationViewHelper
  def get_basic_editor_views(model_name, things_to_look_for)
    it "gets the index" do
      # I was unable to get the later attributes call to work unless factorygirl call was within the test
      @sample_object = FactoryGirl.create(model_name.to_sym)
      model_path = url_for(:action => 'index', :controller => model_name.pluralize)
      visit model_path
      page.should have_content("LIMS") # This is in the nav bar

      page.should have_css('#sidebar')
      page.should have_content(@sample_object.attributes[things_to_look_for[0]])
      page.should have_content("#{model_name.pluralize.capitalize}") # This is in the side bar
  #    page.should have_content("XXX") # this is so the test does not pass and I can keep re-running it alone
    end
    it "visits a creation form" do
      @sample_object = FactoryGirl.create(model_name.to_sym)
      model_path = url_for(:action => 'new', :controller => model_name.pluralize)
      visit model_path
      page.should have_content("LIMS")
      page.should have_content(things_to_look_for[0].titlecase)
      page.should have_content("New #{model_name.capitalize}")
    end
    it "visits a display page" do
      #@sample_object = model_name.singularize.classify.constantize.create!
      @sample_object = FactoryGirl.create(model_name.to_sym)
      #@sample_object2 = Object.const_get(model_name.titlecase).new
      #@sample_object2.save.
      #visit url_for(:id => @sample_object2.id, :action => 'show', :controller => model_name.pluralize)
      model_path = url_for(@sample_object)
      visit model_path
      #page.should have_content("LIMS")
      #page.should have_content(things_to_look_for[0].titlecase)
    end
  end
end