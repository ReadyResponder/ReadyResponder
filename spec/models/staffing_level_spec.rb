require 'rails_helper'

# Tasks can be [Empty, Inadequate, Adequate, Satisfied, Full].
# Each task has min, desired and max staffing.
# If assignments are zero, then empty.
# Above zero, but below min, inadequate.
# Above min, but below desired, adequate.
# Above desired, satisfied.
# At max, full.
#
# Events have many tasks
# An event's staffing level is ditacted by the event's worst case task
# staffing-level.
#
# Let's say I have a shelter event, with two tasks. Medical intake and parking.
# If medical intake were satisfied, but parking was empty, the event should be
# Empty.
#
# StaffingLevel.staffing_level[:staffing_level_number] returns the worst case
# staffing-level of all currently happening events.
# If there are no currently happening events, it returns the staffing level of
# the next event to occur.
#
# The method returns an integer 0-4 as follows:
#
# {
#   'Empty' => 0,
#   'Inadequate' => 1,
#   'Adequate' => 2,
#   'Satisfied' => 3,
#   'Full' => 4
# }
#
# errors return 500

RSpec.describe StaffingLevel do
  describe ".staffing_level" do
    let(:department) { create(:department, shortname: "CERT")}
    let(:person1) { create(:person, department: department) }
    let(:person2) { create(:person, department: department) }
    let(:person3) { create(:person, department: department) }
    let(:person4) { create(:person, department: department) }
    let(:person5) { create(:person, department: department) }
    let(:title1) { create(:title, name: "title 1")}
    let(:title2) { create(:title, name: "title 2")}

    context "single currently happening event" do
      before(:each) do
        @event = create(:event, {
            start_time: 1.hour.ago,
            end_time: 1.hour.from_now,
            departments: [department]
          })
        @task1 = create(:task, {
            event_id: @event.id,
            status: 'Active',
            start_time: 1.hour.ago,
            end_time: 1.hour.from_now
          })
        @requirement1 = create(:requirement, {
            task_id: @task1.id,
            title: title1,
            minimum_people: 2,
            maximum_people: 5,
            desired_people: 3
          })
      end

      it "returns 0 when at least 1 task is Empty" do
        expect(StaffingLevel.staffing_level[:staffing_level_number]).to eq(0)
      end

      it "returns 1 when at least 1 task is Inadequate and no tasks are worse" do
        create(:assignment, {
          person: person1,
          requirement: @requirement1
        })
        expect(StaffingLevel.staffing_level[:staffing_level_number]).to eq(1)
      end

      it "returns 2 when at least 1 task is Adquate and no tasks are worse" do
        [person1, person2].each do |person|
          create(:assignment, {
            person: person,
            requirement: @requirement1
          })
        end
        expect(StaffingLevel.staffing_level[:staffing_level_number]).to eq(2)
      end

      it "returns 3 when at least 1 task is Satisfied and no tasks are worse" do
        [person1, person2, person3].each do |person|
          create(:assignment, {
            person: person,
            requirement: @requirement1
          })
        end
        expect(StaffingLevel.staffing_level[:staffing_level_number]).to eq(3)
      end

      it "returns 4 when all tasks are Full" do
        [person1, person2, person3, person4, person5].each do |person|
          create(:assignment, {
            person: person,
            requirement: @requirement1
          })
        end
        expect(StaffingLevel.staffing_level[:staffing_level_number]).to eq(4)
      end

      it "uses the worst case task if event has multiple tasks" do
        @task2 = create(:task, {
          event_id: @event.id,
          status: 'Active',
          start_time: 1.hour.ago,
          end_time: 1.hour.from_now
        })
      @requirement2 = create(:requirement, {
          task_id: @task2.id,
          title: title1,
          minimum_people: 2,
          maximum_people: 5,
          desired_people: 3
        })
        [person1, person2, person3].each do |person|
          create(:assignment, {
            person: person,
            requirement: @requirement1
          })
        end
        create(:assignment, {
          person: person4,
          requirement: @requirement2
        })
        expect(StaffingLevel.staffing_level[:staffing_level_number]).to eq(1)
      end
    end

    context "multiple currently happening events" do
      before(:each) do
        @event1 = create(:event, {
            start_time: 1.hour.ago,
            end_time: 1.hour.from_now,
            departments: [department]
          })
        @task1 = create(:task, {
            event_id: @event1.id,
            status: 'Active',
            start_time: 1.hour.ago,
            end_time: 1.hour.from_now
          })
        @requirement1 = create(:requirement, {
            task_id: @task1.id,
            title: title1,
            minimum_people: 2,
            maximum_people: 5,
            desired_people: 3
          })
        @event2 = create(:event, {
            start_time: 1.hour.ago,
            end_time: 1.hour.from_now,
            departments: [department]
          })
        @task2 = create(:task, {
            event_id: @event2.id,
            status: 'Active',
            start_time: 1.hour.ago,
            end_time: 1.hour.from_now
          })
        @requirement2 = create(:requirement, {
            task_id: @task2.id,
            title: title2,
            minimum_people: 2,
            maximum_people: 5,
            desired_people: 3
          })
      end

      it "returns the worse case event staffing level" do
        [person1, person2, person3].each do |person|
          create(:assignment, {
            person: person,
            requirement: @requirement1
          })
        end

        [person4].each do |person|
          create(:assignment, {
            person: person,
            requirement: @requirement2
          })
        end

        expect(StaffingLevel.staffing_level[:staffing_level_number]).to eq(1)
      end
    end

    context "no currently happening event" do
      before(:each) do
        @event = create(:event, {
            start_time: 10.hours.from_now,
            end_time: 11.hours.from_now,
            departments: [department]
          })
        @task1 = create(:task, {
            event_id: @event.id,
            status: 'Active',
            start_time: 1.hour.ago,
            end_time: 1.hour.from_now
          })
        @requirement1 = create(:requirement, {
            task_id: @task1.id,
            title: title1,
            minimum_people: 2,
            maximum_people: 5,
            desired_people: 3
          })
      end

      it "finds the next event to happen and returns the staffing_level" do
        [person1, person2].each do |person|
          create(:assignment, {
            person: person,
            requirement: @requirement1
          })
        end
        expect(StaffingLevel.staffing_level[:staffing_level_number]).to eq(2)
      end
    end

    context "when there is an internal server error" do
      it "returns 500" do

        expect(StaffingLevel.staffing_level[:staffing_level_number]).to eq(500)
      end
    end
  end
end
