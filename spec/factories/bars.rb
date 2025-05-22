FactoryBot.define do
  factory :bar do
    sequence(:name) { |n| "Bar #{n}" }
    sequence(:description) { |n| "Description #{n}" }
    association :foo
  end
end 