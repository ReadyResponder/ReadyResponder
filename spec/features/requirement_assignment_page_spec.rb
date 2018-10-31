require 'rails_helper'

RSpec.feature 'Requirement Assignment page' do
  context 'logged in as an Editor and given an assignment with event, task, requirement' do
    before(:each) do
      sign_in_as('Editor')
    end

    context 'given an assignment with all dependancies' do
      before(:each) do

        @department = create(:department)
        @event = create(:event, title: 'The Event', id_code: 'event0132',
                        start_time: 1.day.ago, end_time: 1.day.from_now,
                        departments: [@department])
        @person = create(:person, department: @department)
        @task = create(:task, event: @event)
        @skill = create(:skill)
        @requirement = create(:requirement, task: @task, skill: @skill)
        @assignment = create(:assignment, person: @person, requirement: @requirement, start_time: 1.day.ago, end_time: 1.day.from_now)
      end

      scenario 'can be created from the requirement page' do
        visit requirement_path(@requirement)

        click_on 'New Assignment'

        expect(page).to have_content 'New Assignment'
        expect(page).to have_content @requirement.title
        expect(page).to have_content @assignment.requirement
        select @person, from: 'Person'

        click_button 'Create Assignment'

        expect(page).to have_content 'Assignment was successfully created.'
      end

      scenario 'can be edited from the requirement page' do
        visit requirement_path(@requirement)

        click_link 'Edit'

        expect(page).to have_content 'Assignment for:'
        expect(page).to have_content @assignment.person.name
        expect(page).to have_content @assignment.requirement

        click_button 'Update Assignment'

        expect(page).to have_content 'Assignment was successfully updated.'
      end
    end
  end
end
