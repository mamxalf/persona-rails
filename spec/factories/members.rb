FactoryBot.define do
  factory :member do
    user { nil }
    subscription { '2022-06-14' }
    is_active { false }
    settings { '' }
  end
end
