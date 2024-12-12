FactoryBot.define do
  factory :custom_field_option do
    value { "MyString" }
    custom_field { nil }
  end
end
