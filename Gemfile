source 'https://rubygems.org'

gem 'rails', '~> 4.2.7'

gem 'rack'
gem 'ransack'
gem 'carrierwave'
gem "pg", "~> 0.17.0"
gem 'rmagick', '~> 2.15.4'
gem 'simple_form'
gem 'redcarpet'
gem 'geocoder'
gem 'cancancan'
#gem "taps"
#gem 'validates_timeliness', '~> 3.0'

gem 'rqrcode'
gem 'vcardigan'

gem 'therubyracer'
gem 'jquery-turbolinks'

source 'https://rails-assets.org' do
  gem 'rails-assets-datetimepicker'
end

# Handles text messages and voice calls
gem 'twilio-ruby', '~> 4.11.1'

#Handles authentication
gem 'devise', '~> 3.0'

# For model versioning
gem 'paper_trail'

#For nested forms
gem 'cocoon'

group :test, :development do
  gem 'dotenv-rails'
  gem 'thin'
  gem "rspec-rails"
  # gem 'rspec-activemodel-mocks' # TODO: remove if we no longer need mock_model or stub_model
  gem "factory_girl_rails"
  gem "capybara"
  # Use selenium and chrome for handling JS automated testing
  gem 'selenium-webdriver'
  gem 'chromedriver-helper', '1.0.0'
  gem "guard-rspec", require: false
  gem 'guard-livereload'
  gem "mailcatcher"
  gem "launchy"
  gem "letter_opener"
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'meta_request'
  gem 'database_cleaner', '1.0.1'
  gem 'test-unit'
  gem 'pry'

  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 3.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

  # Use Capistrano for deployment
  gem 'capistrano-rails'


  # Helps you figure out where a piece of the UI is coming from by
  # adding comments to the source code at the begin and end of each template.
  gem 'noisy_partials', git: 'git://github.com/gwshaw/noisy_partials.git'
end

group :production do
  # Use Unicorn as the app server
  gem 'unicorn'
end

group :test do
  gem 'shoulda-matchers'
  gem 'simplecov'

  # Allows you to freeze time during tests
  gem 'timecop'
end

gem 'sass-rails'
gem 'uglifier', '>= 1.0.3'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
gem 'bcrypt-ruby', '~> 3.0.0'

# # Deploy with Capistrano
# gem 'capistrano', '~> 2.15'
# # This is used by Capistrano, but 2.8 has issues
# gem "net-ssh", "~> 2.7.0"

gem 'jquery-ui-rails'
gem 'bootstrap-sass', '3.3.7'
# gem 'chosen-rails'

gem 'protected_attributes'
