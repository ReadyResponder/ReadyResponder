require 'rails_helper'

RSpec.describe "GET /api/staffinglevel", type: :request do
  context "When there are no events" do
    it "returns the error staffing level" do
      expected_json = {
        "staffing_level_name" => "Error",
        "staffing_level_number" => 500,
        "staffing_level_percentage" => "NaN"
      }

      get "/api/staffinglevel"

      expect(json_body).to eq(expected_json)
    end
  end

  context "When there are events" do
    it "returns the staffing level for the next event" do
      department = create(:department)
      event = create(
        :event,
        start_time: 1.hour.ago,
        end_time: 1.hour.from_now
      )
      task = create(
        :task,
        event: event,
        start_time: 1.hour.ago,
        end_time: 1.hour.from_now
      )
      title = create(:title)
      requirement = create(
        :requirement,
        task: task,
        title: title,
        minimum_people: 1,
        maximum_people: 2,
        desired_people: 1
      )
      person = create(:person, department: department)
      create(:assignment, person: person, requirement: requirement)

      expected_json = {
        "staffing_level_name" => "Satisfied",
        "staffing_level_number" => 3,
        "staffing_level_percentage" => 80
      }

      get "/api/staffinglevel"

      expect(json_body).to eq(expected_json)
    end
  end
end

def json_body
  JSON.parse(response.body)
end
