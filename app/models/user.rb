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
class User < ApplicationRecord
  has_one :auth, as: :auth_able, dependent: :destroy, class_name: 'Auth'
end
