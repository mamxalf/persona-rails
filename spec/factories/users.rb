# == Schema Information
#
# Table name: users
#
#  id           :uuid             not null, primary key
#  address      :text
#  email        :string           default(""), not null
#  full_name    :string
#  phone_number :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_users_on_email         (email) UNIQUE
#  index_users_on_phone_number  (phone_number) UNIQUE
#
FactoryBot.define do
  factory :user do
  end
end
