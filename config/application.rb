require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ReadyResponder
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1

    config.filter_parameters << :value
    config.autoload_paths << Rails.root.join('services')
    config.assets.precompile += %w(*.js)
    config.autoload_paths << Rails.root.join('lib')
    config.time_zone = 'Eastern Time (US & Canada)'
    # config.active_record.raise_in_transactional_callbacks = true

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
