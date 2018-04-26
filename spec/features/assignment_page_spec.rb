require 'rails_helper'

RSpec.feature 'Assignment page' do
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

      scenario 'can be accessed from the assignments list' do
        visit assignments_path

        within('table.assignments tbody') do
          expect(page).to have_content @assignment.person.name
          expect(page).to have_content @assignment.start_time
          expect(page).to have_content @assignment.end_time
          expect(page).to have_content @assignment.requirement
          expect(page).to have_content @assignment.status
          expect(page).to have_content @assignment.duration
        end

        click_link @assignment.person.name

        expect(page).to have_content @assignment.person.name
        expect(page).to have_content @assignment.event.title
        expect(page).to have_content @assignment.requirement
      end

      scenario 'can be edited from the assignments list' do
        visit assignments_path

        click_link 'Edit'

        expect(page).to have_content 'Assignment for:'
        expect(page).to have_content @assignment.person.name
        expect(page).to have_content @assignment.requirement

        click_button 'Update Assignment'

        expect(page).to have_content 'Assignment was successfully updated.'
      end

      scenario 'shows assignment information' do
        visit assignment_path(@assignment)

        expect(page).to have_content @assignment.person.name
        expect(page).to have_content @assignment.event.title
        expect(page).to have_content @assignment.requirement
      end
    end
  end
end
