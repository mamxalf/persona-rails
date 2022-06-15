# == Schema Information
#
# Table name: members
#
#  id           :uuid             not null, primary key
#  is_active    :boolean
#  settings     :jsonb
#  subscription :date
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  user_id      :uuid             not null
#
FactoryBot.define do
  factory :member do
    user { nil }
    subscription { '2022-06-14' }
    is_active { false }
    settings { '' }
  end
end
