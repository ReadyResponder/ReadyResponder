FactoryBot.define do
  factory :error_base, class: Error::Base do
    skip_create

    code 1
    description 'An Error'

    initialize_with { new(attributes) }
  end
end
