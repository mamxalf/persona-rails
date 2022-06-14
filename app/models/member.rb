class Member < ApplicationRecord
  belongs_to :user
  has_one :auth, as: :auth_able, dependent: :destroy, class_name: 'Auth'
end
