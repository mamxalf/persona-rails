# == Schema Information
#
# Table name: auths
#
#  id                     :uuid             not null, primary key
#  auth_able_type         :string           not null
#  current_sign_in_at     :datetime
#  current_sign_in_ip     :string
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  last_sign_in_at        :datetime
#  last_sign_in_ip        :string
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  role                   :string           default("user"), not null
#  sign_in_count          :integer          default(0), not null
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  auth_able_id           :uuid             not null
#
# Indexes
#
#  index_auths_on_auth_able_id          (auth_able_id)
#  index_auths_on_auth_able_type        (auth_able_type)
#  index_auths_on_email                 (email) UNIQUE
#  index_auths_on_reset_password_token  (reset_password_token) UNIQUE
#
class Auth < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :trackable,
         :recoverable, :rememberable, :validatable

  belongs_to :auth_able, polymorphic: true, optional: true
end
