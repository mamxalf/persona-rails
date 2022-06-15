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
require 'rails_helper'

RSpec.describe Member, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
