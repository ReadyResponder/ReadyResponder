require 'rails_helper'

RSpec.feature 'Event page' do
  context 'logged in as an Editor and given an event' do
    before(:all) do
      sign_in_as('Editor')
    end

    context 'where members have differing availabilities' do
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

      scenario 'shows availablity properly' do
        # av stands for available, pav stands for partially available
        # uav is unavailable
        # This person is available at the exact times
        av_hero_exactly_ontime = create(:person, firstname: 'Adam', department: @mrc)
        create(:availability, person: av_hero_exactly_ontime, status: 'Available',
          start_time: @event.start_time, end_time: @event.end_time)

        # This person is available , arriving early
        av_hero_arrive_early_leave_ontime = create(:person, department: @mrc)
        create(:availability, person: av_hero_arrive_early_leave_ontime, status: 'Available',
          start_time: @event.start_time - 1.hour, end_time: @event.end_time)

        # This person is available, staying late
        av_hero_arrive_ontime_leave_late = create(:person, department: @mrc)
        create(:availability, person: av_hero_arrive_ontime_leave_late, status: 'Available',
          start_time: @event.start_time, end_time: @event.end_time + 1.hour)

        av_hero_arrive_early_leave_late = create(:person, department: @mrc)
        create(:availability, person: av_hero_arrive_early_leave_late, status: 'Available',
          start_time: @event.start_time - 1.hour, end_time: @event.end_time + 1.hour)

        # These people should be partially available
        pav_hero_arrive_late_leave_ontime = create(:person, department: @mrc)
        create(:availability, person: pav_hero_arrive_late_leave_ontime, status: 'Available',
          start_time: @event.start_time + 1.hour, end_time: @event.end_time)

        pav_hero_arrive_late_leave_late = create(:person, department: @mrc)
        create(:availability, person: pav_hero_arrive_late_leave_late, status: 'Available',
          start_time: @event.start_time + 1.hour, end_time: @event.end_time + 1.hour)

        pav_hero_arrive_late_leave_early = create(:person, department: @mrc)
        create(:availability, person: pav_hero_arrive_late_leave_early, status: 'Available',
          start_time: @event.start_time + 1.hour, end_time: @event.end_time - 1.hour)

        pav_hero_arrive_ontime_leave_early = create(:person, department: @mrc)
        create(:availability, person: pav_hero_arrive_ontime_leave_early, status: 'Available',
          start_time: @event.start_time, end_time: @event.end_time - 1.hour)

        uav_hero_exact_times = create(:person, department: @mrc)
        create(:availability, person: uav_hero_exact_times,
          status: 'Unavailable',
          start_time: @event.start_time, end_time: @event.end_time - 1.hour)

        uav_hero_exact_start_late_end = create(:person, department: @mrc)
        create(:availability, person: uav_hero_exact_start_late_end,
          status: 'Unavailable',
          start_time: @event.start_time, end_time: @event.end_time + 1.hour)

        uav_hero_early_start_exact_end = create(:person, department: @mrc)
        create(:availability, person: uav_hero_early_start_exact_end,
          status: 'Unavailable',
          start_time: @event.start_time - 1.hour, end_time: @event.end_time)

        uav_hero_early_start_late_end = create(:person, department: @mrc)
        create(:availability, person: uav_hero_early_start_late_end,
          status: 'Unavailable',
          start_time: @event.start_time - 1.hour, end_time: @event.end_time + 1.hour)

        visit event_path(@event)

        within("table#event-status tr##{@mrc.name.parameterize}-status") do
          expect(page).to have_css('.event-labels[title="Assigned to THIS Event"]', text: '0')
          expect(page).to have_css('.event-labels[title="Available"]', text: '4')
          expect(page).to have_css('.event-labels[title="Partially Available"]', text: '4')
          expect(page).to have_css('.event-labels[title="Unavailable"]', text: '4')
          expect(page).to have_css('.event-labels[title="No Response"]', text: '0')
        end

        within("table#availabilities") do
        # First, people who are fully available
          expect(page).to have_css('.success',
            text: av_hero_exactly_ontime.fullname,
            :count => 1)
          expect(page).not_to have_css('.warning',
            text: av_hero_exactly_ontime.fullname)
          expect(page).not_to have_css('.danger',
            text: av_hero_exactly_ontime.fullname)

          expect(page).to have_css('.success',
            text: av_hero_arrive_early_leave_ontime.fullname,
            :count => 1)
          expect(page).not_to have_css('.warning',
            text: av_hero_arrive_early_leave_ontime.fullname)
          expect(page).not_to have_css('.danger',
            text: av_hero_arrive_early_leave_ontime.fullname)

          expect(page).to have_css('.success',
            text: av_hero_arrive_ontime_leave_late.fullname,
            :count => 1)
          expect(page).not_to have_css('.warning',
            text: av_hero_arrive_ontime_leave_late.fullname)
          expect(page).not_to have_css('.danger',
            text: av_hero_arrive_ontime_leave_late.fullname)

          expect(page).to have_css('.success',
            text: av_hero_arrive_early_leave_late.fullname,
            :count => 1)
          expect(page).not_to have_css('.warning',
            text: av_hero_arrive_early_leave_late.fullname)
          expect(page).not_to have_css('.danger',
            text: av_hero_arrive_early_leave_late.fullname)

        # Then people who are partially available
          expect(page).not_to have_css('.success',
            text: pav_hero_arrive_late_leave_ontime.fullname)
          expect(page).to have_css('.warning',
            text: pav_hero_arrive_late_leave_ontime.fullname,
            :count => 1)
          expect(page).not_to have_css('.danger',
            text: pav_hero_arrive_late_leave_ontime.fullname)

          expect(page).not_to have_css('.success',
            text: pav_hero_arrive_late_leave_late.fullname)
          expect(page).to have_css('.warning',
            text: pav_hero_arrive_late_leave_late.fullname,
            :count => 1)
          expect(page).not_to have_css('.danger',
            text: pav_hero_arrive_late_leave_late.fullname)

          expect(page).not_to have_css('.success',
            text: pav_hero_arrive_late_leave_early.fullname)
          expect(page).to have_css('.warning',
            text: pav_hero_arrive_late_leave_early.fullname,
            :count => 1)
          expect(page).not_to have_css('.danger',
            text: pav_hero_arrive_late_leave_early.fullname)

          expect(page).not_to have_css('.success',
            text: pav_hero_arrive_ontime_leave_early.fullname)
          expect(page).to have_css('.warning',
            text: pav_hero_arrive_ontime_leave_early.fullname,
            :count => 1)
          expect(page).not_to have_css('.danger',
            text: pav_hero_arrive_ontime_leave_early.fullname)

        # Finally, people who are not available at all
          expect(page).not_to have_css('.success',
            text: uav_hero_exact_times.fullname)
          expect(page).not_to have_css('.warning',
            text: uav_hero_exact_times.fullname)
          expect(page).to have_css('.danger',
            text: uav_hero_exact_times.fullname,
            :count => 1)


        end

      end
    end
  end
end
