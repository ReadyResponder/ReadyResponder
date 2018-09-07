require 'rails_helper'

RSpec.feature 'Event page' do
  context 'logged in as an Editor and given an event' do
    before(:all) do
      sign_in_as('Editor')
    end
    context 'where assignments are present'
      before(:each) do
        @mrc = create(:department, name: 'Medical Reserve Dept.')
        @event = create(:event, departments: [@mrc],
                        start_time: 1.hour.from_now, end_time: 6.hours.from_now,
                        min_title: Person::TITLE_ORDER.keys.last)
        @task = create(:task, event: @event)
        @skill = create(:skill)
        @requirement = create(:requirement, task: @task, skill: @skill)
      end

      scenario 'they show on availablity table properly' do
        av_hero_new_assigned = create(:person,
               lastname: 'New_assignment',
               department: @mrc)
        create(:assignment, requirement: @requirement,
               person: av_hero_new_assigned, status: 'New',
               start_time: @event.start_time, end_time: @event.end_time)

        av_hero_active_assigned = create(:person,
                  lastname: 'Active_assignment',
                  department: @mrc)
        create(:assignment, requirement: @requirement,
              person: av_hero_active_assigned, status: 'Active',
              start_time: @event.start_time, end_time: @event.end_time)

        av_hero_cancelled_assigned = create(:person,
                   lastname: 'Cancelled_assignment',
                   department: @mrc)
        create(:assignment, requirement: @requirement,
               person: av_hero_cancelled_assigned, status: 'Cancelled',
               start_time: @event.start_time, end_time: @event.end_time)

        visit event_path(@event)

        within("table#availabilities") do
        # First, people who are fully available
          expect(page).to have_css('.info',
            text: av_hero_new_assigned.fullname,
            :count => 1)

          expect(page).to have_css('.info',
            text: av_hero_active_assigned.fullname,
            :count => 1)

          expect(page).not_to have_css('.info',
            text: av_hero_cancelled_assigned.fullname)

          #expect(page).not_to have_css('.danger',            text: av_hero_exactly_ontime.fullname)
      end
    end
  end
end
