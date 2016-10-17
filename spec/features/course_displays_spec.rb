require 'rails_helper'
#Don't use capybara (ie visit/have_content) and rspec matchers together  {response.status.should be(200)}

RSpec.describe "Course" do  
  describe " when not logged in" do
    it "should not allow much of anything" do
      visit courses_path
      expect(page).not_to have_content("Listing")
      expect(page).to have_content('You need to sign in')
      visit new_course_path
      expect(page).to have_content('You need to sign in')
      an_example = create(:course, name: 'Pottery')
      visit edit_course_path(an_example)
      expect(page).to have_content('You need to sign in')
      expect(page).not_to have_content('Pottery')
      visit course_path(an_example)
      expect(page).to have_content('You need to sign in')
      expect(page).not_to have_content('Pottery')
    end
  end
      
  describe "should display" do
    before  do
      somebody = create(:user)
      r = create(:role, name: 'Editor')
      somebody.roles << r
      visit new_user_session_path
      fill_in('user_email', :with => somebody.email)
      fill_in('user_password', :with => somebody.password)
      click_on 'Sign in'
    end

  
   it "a list" do
      an_example = create(:course, name: 'Zombie Hunting')
      visit courses_path
      within_table("courses") do
        expect(page).to have_content("Courses")
      end
      expect(page).to have_content("Home") # This is in the nav bar
      expect(page).to have_link(an_example.name)
      click_on an_example.name
      expect(page).to have_content(an_example.name)
    end

    it "a new course form that creates a course" do
      visit new_course_path
      expect(page).to have_content('New Course')
      fill_in 'course_name', :with => 'Basket Weaving'
      select('Active', :from => 'course_status')
      fill_in 'course_description', :with => 'A creative and fulfilling pastime'
      #select('Active', :from => 'course_skill')
      select('General', :from => 'course_category')
      fill_in 'course_duration', :with => '2'
      fill_in 'course_term', :with => '20'
      fill_in 'course_comments', :with => 'Not for the faint of heart'
      click_on 'Create Course'
      visit courses_path
      expect(page).to have_content('Basket Weaving')
    end
    
    it 'should update a course' do
      an_example = create(:course, name: 'Zombie Hunting')
      visit edit_course_path(an_example)
      fill_in 'course_name', :with => 'Skydiving'
      click_on 'Update Course'
      visit courses_path
      expect(page).not_to have_content('Zombie Hunting')
      expect(page).to have_content('Skydiving')
    end
  end
end
