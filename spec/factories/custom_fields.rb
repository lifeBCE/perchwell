FactoryBot.define do
  factory :custom_field do
    name { "MyString" }
    display_name { "MyString" }
    field_type { 1 }
    client { association :client }
  end
end
