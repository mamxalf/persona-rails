# frozen_string_literal: true

require 'rails_helper'
RSpec.describe Core::UseCases::Members::UserCreateNewMember do
  let(:user) { create :user }
  let(:params) do
    {
      email:        'user1@test.com',
      is_active:    true,
      subscription: (Time.now + 30.day),
      user_id:      user.id
    }
  end
  let(:result) do
    described_class.new(described_class.parameters(params)).result
  end
  describe '#result' do
    context 'when call ping' do
      it 'successfully created' do
        expect(result.success?).to be true
        expect(result.success).to have_attributes(
                                    email:        'user1@test.com',
                                    password:     an_instance_of(String),
                                    role:         'user',
                                    subscription: an_instance_of(Date)
                                  )
      end
    end
  end
end
