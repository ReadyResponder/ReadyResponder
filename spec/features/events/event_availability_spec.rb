require 'rails_helper'

RSpec.feature 'Event page' do
  context 'logged in as an Editor and given an event with departments and rank' do
    before(:each) do
      sign_in_as('Editor')
    end

    context 'given an event with departments where members have differing availabilities' do
      before(:each) do
        Timecop.freeze

        @mrc = create(:department, name: 'Medical Reserve Dept.')
        @event = create(:event, departments: [@mrc],
                        start_time: 1.hour.from_now, end_time: 6.hours.from_now,
                        min_title: Person::TITLE_ORDER.keys.last)
      end

      after(:each) do
        Timecop.return
      end

      scenario 'shows partially available people properly' do
        # av stands for available, pav stands for partially available
        # uav is unavailable
        # This person is available at the exact times
        av_responder_exactly_ontime = create(:person, department: @mrc)
        create(:availability, person: av_responder_exactly_ontime, status: 'Available',
          start_time: @event.start_time, end_time: @event.end_time)

        # This person is available , arriving early
        av_responder_arrive_early_leave_ontime = create(:person, department: @mrc)
        create(:availability, person: av_responder_arrive_early_leave_ontime, status: 'Available',
          start_time: @event.start_time - 1.hour, end_time: @event.end_time)

        # This person is available, staying late
        av_responder_arrive_ontime_leave_late = create(:person, department: @mrc)
        create(:availability, person: av_responder_arrive_ontime_leave_late, status: 'Available',
          start_time: @event.start_time, end_time: @event.end_time + 1.hour)

        av_responder_arrive_early_leave_late = create(:person, department: @mrc)
        create(:availability, person: av_responder_arrive_early_leave_late, status: 'Available',
          start_time: @event.start_time - 1.hour, end_time: @event.end_time + 1.hour)

        # These people should be partially available
        pav_responder_arrive_late_leave_ontime = create(:person, department: @mrc)
        create(:availability, person: pav_responder_arrive_late_leave_ontime, status: 'Available',
          start_time: @event.start_time + 1.hour, end_time: @event.end_time)

        pav_responder_arrive_late_leave_late = create(:person, department: @mrc)
        create(:availability, person: pav_responder_arrive_late_leave_late, status: 'Available',
          start_time: @event.start_time + 1.hour, end_time: @event.end_time + 1.hour)

        pav_responder_arrive_late_leave_early = create(:person, department: @mrc)
        create(:availability, person: pav_responder_arrive_late_leave_early, status: 'Available',
          start_time: @event.start_time + 1.hour, end_time: @event.end_time - 1.hour)

        pav_responder_arrive_ontime_leave_early = create(:person, department: @mrc)
        create(:availability, person: pav_responder_arrive_ontime_leave_early, status: 'Available',
          start_time: @event.start_time, end_time: @event.end_time - 1.hour)

        uav_responder_exact_times = create(:person, department: @mrc)
        create(:availability, person: uav_responder_exact_times,
          status: 'Unavailable',
          start_time: @event.start_time, end_time: @event.end_time - 1.hour)

        uav_responder_exact_start_late_end = create(:person, department: @mrc)
        create(:availability, person: uav_responder_exact_start_late_end,
          status: 'Unavailable',
          start_time: @event.start_time, end_time: @event.end_time + 1.hour)

        uav_responder_early_start_exact_end = create(:person, department: @mrc)
        create(:availability, person: uav_responder_early_start_exact_end,
          status: 'Unavailable',
          start_time: @event.start_time - 1.hour, end_time: @event.end_time)

        uav_responder_early_start_late_end = create(:person, department: @mrc)
        create(:availability, person: uav_responder_early_start_late_end,
          status: 'Unavailable',
          start_time: @event.start_time - 1.hour, end_time: @event.end_time + 1.hour)

        visit event_path(@event)
save_and_open_page
        within("table#event-status tr##{@mrc.name.parameterize}-status") do
          expect(page).to have_css('.event-labels[title="Assigned to THIS Event"]', text: '0')
          expect(page).to have_css('.event-labels[title="Available"]', text: '4')
          expect(page).to have_css('.event-labels[title="Partially Available"]', text: '4')
          expect(page).to have_css('.event-labels[title="Unavailable"]', text: '4')
          expect(page).to have_css('.event-labels[title="No Response"]', text: '0')
        end
        within("table#availabilities") do
          expect(page).to have_content('Partially Available')
        end
      end
    end
  end
end
