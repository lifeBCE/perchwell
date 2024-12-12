FactoryBot.define do
  factory :building do
    street_1 { "123 Fake St" }
    city { "Austin" }
    state { "TX" }
    zipcode { "78727" }
    custom_fields { {} }
    client { association :client }
  end
end
