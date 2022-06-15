# == Schema Information
#
# Table name: examples
#
#  id         :bigint           not null, primary key
#  title      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :example do
    title { "MyString" }
  end
end
