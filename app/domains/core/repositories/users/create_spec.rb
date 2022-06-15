# frozen_string_literal: true

require 'rails_helper'
RSpec.describe Core::Repositories::Users::Create do
  let(:params) do
    {
      full_name:    'User Test 1',
      email:        'user1@test.com',
      address:      'Kowangan, Bumiphala',
      phone_number: '6285727617123',
      password:     'Test123.',
      role:         'admin'
    }
  end

  describe '#RESULT' do
    context 'when call ping' do
      let(:result) do
        described_class.new(params).call
      end
      it 'should be successfully' do
        expect(result.success?).to be true
        expect(result.success.class).to eql Core::Entities::User
        expect(result.success.attributes).to eql params.except(:password, :role)

        # validate auth
        auth = Auth.find_by_email(params[:email])
        expect(auth.valid_password?(params[:password])).to eql true
        expect(auth.auth_able).to eql User.find_by_email(params[:email])
      end
    end
  end
end
