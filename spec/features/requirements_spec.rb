require 'rails_helper'

RSpec.describe "Requirements" do
  before(:each) { sign_in_as('Editor') }

  # This can only be used if we have a factory that works with no arguments
  # get_nested_editor_views('task', 'requirement', ['minimum_people', 'maximum_people', 'desired_people'])

  let(:max_ppl) { 5 + rand(25) }
  let(:desired_ppl) { 1 + rand((max_ppl * 0.8).floor + 1) }
  let(:min_ppl) { 1 + rand((desired_ppl * 0.5).floor + 1) }

  describe "creates" do
    it "requirements" do
      @event = create(:event)
      @task = create(:task, event: @event)
      @skill = create(:skill)
      visit new_task_requirement_path(@task)
      select @skill.name, from: :requirement_skill_id
      fill_in "requirement_desired_people", with: desired_ppl
      fill_in "requirement_maximum_people", with: max_ppl
      fill_in "requirement_minimum_people", with: min_ppl
      click_on 'Create Requirement'
      expect(page).to have_content "Requirement was successfully created."
      expect(page).to have_content @skill.name
      expect(page).to have_content "#{desired_ppl}"
      expect(page).to have_content "#{min_ppl}"
      expect(page).to have_content "#{max_ppl}"
      visit task_path(@task)
      click_on @skill.name
      expect(page).to have_content @skill.name
      expect(page).to have_content "Desired People: #{desired_ppl}"
      expect(page).to have_content "Minimum People: #{min_ppl}"
      expect(page).to have_content "Maximum People: #{max_ppl}"
    end
  end
end
