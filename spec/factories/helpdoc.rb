# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :helpdoc do
    title "MyString"
    contents "MyText"
    help_for_view "MyString"
    help_for_section "MyString"
  end
end
