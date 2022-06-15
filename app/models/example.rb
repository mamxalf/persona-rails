# == Schema Information
#
# Table name: examples
#
#  id         :bigint           not null, primary key
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Example < ApplicationRecord
end
