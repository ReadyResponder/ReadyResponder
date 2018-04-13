require 'rails_helper'

RSpec.feature 'Event page' do
  context 'logged in as an Editor and given an event with departments and rank' do
    before(:each) do
      sign_in_as('Editor')
    end

    context 'given an event with a couple of departments and minimum rank' do
      before(:each) do
        @departments = create_list(:department, 2)
        @event = create(:event, title: 'The Event', id_code: 'event0132',
                        start_time: 1.day.ago, end_time: 1.day.from_now,
                        departments: @departments)
      end

      scenario 'can be accessed from the events list' do
        visit events_path

        within('table#events tbody') do
          expect(page).to have_content @event.title
        end

        click_link @event.title

        expect(page).to have_content @event.title
      end

      scenario 'shows basic event information' do
        visit event_path(@event)

        expect(page).to have_content @event.title
        expect(page).to have_content @event.id_code
        expect(page).to have_content @departments[0].name
        expect(page).to have_content @departments[1].name
        expect(page).to have_content @event.min_title
        expect(page).to have_content @event.description
        expect(page).to have_content @event.status
      end
    end

    context 'given an event with associated departments where members have differing availabilities' do
      before(:each) do
        Timecop.freeze

        # Set up the event with multiple departments
        @response_team   = create(:department, name: 'Response Team Dept.')
        @medical_reserve = create(:department, name: 'Medical Reserve Dept.')
        @division_group = create(:department, name: 'Division Group')
        @event = create(:event, departments: [@response_team, @medical_reserve],
                        start_time: 1.day.from_now, end_time: 3.days.from_now,
                        min_title: Person::TITLE_ORDER.keys.last)
      end

      after(:each) do
        Timecop.return
      end

      scenario 'shows assigned people by department' do
        task  = create(:task, event: @event)
        title = create(:title)
        requirement = create(:requirement, task: task, title: title)

        assigned_responder = create(:person, department: @response_team,
                                    title_order: 1)

        create(:assignment, requirement: requirement, person: assigned_responder)

        visit event_path(@event)

        within("table#event-status tr##{@response_team.name.parameterize}-status") do
          expect(page).to have_css('.event-labels[title="Assigned to THIS Event"]', text: '1')
          expect(page).to have_css('.event-labels[title="Available"]', text: '0')
          expect(page).to have_css('.event-labels[title="Partially Available"]', text: '0')
          expect(page).to have_css('.event-labels[title="Unavailable"]', text: '0')
          # The person has not yet responded, even though she is assigned
          expect(page).to have_css('.event-labels[title="No Response"]', text: '1')
        end
        within("table#event-status tr##{@medical_reserve.name.parameterize}-status") do
          expect(page).to have_css('.event-labels[title="Assigned to THIS Event"]', text: '0')
          expect(page).to have_css('.event-labels[title="No Response"]', text: '0')
        end
      end

      scenario 'shows available people by department' do
        available_doc = create(:person, department: @medical_reserve)
        person_from_different_dept = create(:person, department: @division_group)
        create(:availability, person: available_doc, status: 'Available',
               start_time: @event.start_time, end_time: @event.end_time)
        create(:availability, person: person_from_different_dept, status: 'Available',
               start_time: @event.start_time, end_time: @event.end_time)

        visit event_path(@event)

        within("table#event-status tr##{@medical_reserve.name.parameterize}-status") do
          expect(page).to have_css('.event-labels[title="Assigned to THIS Event"]', text: '0')
          expect(page).to have_css('.event-labels[title="Available"]', text: '1')
          expect(page).to have_css('.event-labels[title="Partially Available"]', text: '0')
          expect(page).to have_css('.event-labels[title="Unavailable"]', text: '0')
          expect(page).to have_css('.event-labels[title="No Response"]', text: '0')
        end
        within("table#event-status tr##{@response_team.name.parameterize}-status") do
          expect(page).to have_css('.event-labels[title="Available"]', text: '0')
        end
        within("table#availabilities") do
          expect(page).to have_content('Available')
          expect(page).to have_content(available_doc.name)
          expect(page).not_to have_content(person_from_different_dept.name)
        end
      end

      scenario 'shows partially available people by department' do
        partially_av_responder = create(:person, department: @response_team)
        person_from_different_dept = create(:person, department: @division_group)
        create(:availability, person: partially_av_responder, status: 'Available',
               start_time: @event.start_time + 1.day, end_time: @event.end_time + 1.day)
        create(:availability, person: person_from_different_dept, status: 'Available',
               start_time: @event.start_time + 1.day, end_time: @event.end_time + 1.day)

        visit event_path(@event)

        within("table#event-status tr##{@response_team.name.parameterize}-status") do
          expect(page).to have_css('.event-labels[title="Assigned to THIS Event"]', text: '0')
          expect(page).to have_css('.event-labels[title="Available"]', text: '0')
          expect(page).to have_css('.event-labels[title="Partially Available"]', text: '1')
          expect(page).to have_css('.event-labels[title="Unavailable"]', text: '0')
          expect(page).to have_css('.event-labels[title="No Response"]', text: '0')
        end
        within("table#event-status tr##{@medical_reserve.name.parameterize}-status") do
          expect(page).to have_css('.event-labels[title="Partially Available"]', text: '0')
        end
        within("table#availabilities") do
          expect(page).to have_content('Partially Available')
          expect(page).to have_content(partially_av_responder.name)
          expect(page).not_to have_content(person_from_different_dept.name)
        end
      end

      scenario 'shows unavailable people by department' do
        unavailable_doc = create(:person, department: @medical_reserve)
        person_from_different_dept = create(:person, department: @division_group)
        create(:availability, person: unavailable_doc, status: 'Unavailable',
               start_time: @event.start_time, end_time: @event.end_time)
        create(:availability, person: person_from_different_dept, status: 'Unavailable',
               start_time: @event.start_time, end_time: @event.end_time)

        visit event_path(@event)

        within("table#event-status tr##{@medical_reserve.name.parameterize}-status") do
          expect(page).to have_css('.event-labels[title="Assigned to THIS Event"]', text: '0')
          expect(page).to have_css('.event-labels[title="Available"]', text: '0')
          expect(page).to have_css('.event-labels[title="Partially Available"]', text: '0')
          expect(page).to have_css('.event-labels[title="Unavailable"]', text: '1')
          expect(page).to have_css('.event-labels[title="No Response"]', text: '0')
        end
        within("table#event-status tr##{@response_team.name.parameterize}-status") do
          expect(page).to have_css('.event-labels[title="Unavailable"]', text: '0')
        end
        within("table#availabilities") do
          expect(page).to have_content('Unavailable')
          expect(page).to have_content(unavailable_doc.name)
          expect(page).not_to have_content(person_from_different_dept.name)
        end
      end

      scenario 'shows people that did not respond by department' do
        # Create an unresponsive person, someone with no associated availability
        no_response = create(:person, department: @response_team, title_order: 3)


        visit event_path(@event)

        within("table#event-status tr##{@response_team.name.parameterize}-status") do
          expect(page).to have_css('.event-labels[title="Assigned to THIS Event"]', text: '0')
          expect(page).to have_css('.event-labels[title="Available"]', text: '0')
          expect(page).to have_css('.event-labels[title="Partially Available"]', text: '0')
          expect(page).to have_css('.event-labels[title="Unavailable"]', text: '0')
          expect(page).to have_css('.event-labels[title="No Response"]', text: '1')
        end
        within("table#event-status tr##{@medical_reserve.name.parameterize}-status") do
          expect(page).to have_css('.event-labels[title="No Response"]', text: '0')
        end
        within("table#availabilities") do
          expect(page).not_to have_content('Available')
          expect(page).not_to have_content(no_response.name)
        end
        within("table#generic-people") do
          expect(page).to have_content(no_response.name)
        end
      end
    end
  end
end
