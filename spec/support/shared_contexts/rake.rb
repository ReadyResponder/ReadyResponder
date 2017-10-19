# Credit to Thoughtbot
# https://robots.thoughtbot.com/test-rake-tasks-like-a-boss

# This shared context makes some assumptions about your rake specs:
# 
# 1. each task is tested within a describe block that names it explicitly
# e. g.   describe 'db:seed' do
#         end
#
# 2. each namespace is stored in a file with the same name
# e. g. the rake task users:reset would be in lib/tasks/users.rake

require 'rake'

RSpec.shared_context 'rake', :shared_context => :metadata do
  let(:rake)      { Rake::Application.new }
  let(:task_name) { self.class.top_level_description }
  let(:task_path) { "lib/tasks/#{task_name.split(':').first}" }
  
  subject { rake[task_name] }

  def loaded_files_excluding_current_rake_file
    $".reject { |file| file == Rails.root.join("#{task_path}.rake").to_s }
  end

  before do
    Rake.application = rake
    Rake.application.rake_require(task_path, [Rails.root.to_s], loaded_files_excluding_current_rake_file)

    Rake::Task.define_task(:environment)
  end
end
