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
class Member < ApplicationRecord
  belongs_to :user
  has_one :auth, as: :auth_able, dependent: :destroy, class_name: 'Auth'
end
