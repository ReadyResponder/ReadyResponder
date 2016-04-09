source 'https://rubygems.org'

gem 'rails', '~> 3.2.22'
gem 'rack'
gem 'ransack'
gem 'carrierwave'
gem "pg", "~> 0.17.0"
gem 'rmagick'
gem 'simple_form'
gem 'geocoder'
gem 'cancan'
gem 'strong_parameters'
#gem "taps"
#gem 'validates_timeliness', '~> 3.0'

#Handles authentication
gem 'devise', '~> 2.2.1'

group :test, :development do
  gem 'thin'
  gem "rspec-rails", '~> 3.4.0'
  gem 'rspec-activemodel-mocks' # TODO: remove if we no longer need mock_model or stub_model
  gem "factory_girl_rails", "~> 4.6"
  gem "capybara"
  gem "guard-rspec", require: false
  gem 'guard-livereload'
  gem 'sqlite3'
  gem "mailcatcher"
  gem "launchy"
  gem "letter_opener"
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'meta_request'
  gem 'database_cleaner', '1.0.1'
  gem 'test-unit'
  gem 'poltergeist'
  gem 'pry'
end

group :test do
  gem 'shoulda-matchers'
end

group :assets do
  # Gems used only for assets and not required
  # in production environments by default.
  gem 'jquery-rails'

  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  #The following provides the stylinmg for the datatables, among other things
  gem 'jquery-ui-rails'
  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
  gem 'jquery-datatables-rails', github: 'rweng/jquery-datatables-rails'
  gem 'bootstrap-sass', '~> 2.0.4.1'
  gem 'chosen-rails'
end

# To use ActiveModel has_secure_password
gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
 gem 'unicorn'

# Deploy with Capistrano
gem 'capistrano', '~> 2.15'
# This is used by Capistrano, but 2.8 has issues
gem "net-ssh", "~> 2.7.0"

# To use debugger
# gem 'debugger'
