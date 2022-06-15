# frozen_string_literal: true

require 'rails_helper'
RSpec.describe Core::UseCases::Members::UserGetMembers do
  let(:user) { create :user }
  let(:params) do
    {
      limit:   2,
      offset:  1,
      user_id: user.id
    }
  end

  let(:result) do
    described_class.new(described_class.parameters(params)).result
  end

  before do
    (1..5).each do |i|
      member = create :member, user_id: user.id
      member.build_auth(email: "member#{i}@gmail.com", password: "password#{i}", role: 'user')
      member.save
    end
  end

  describe '#result' do
    context 'when call ping' do
      it 'successfully created' do
        expect(result.success?).to be true
        expect(result.success.pagination.as_json).to eql({ cursor: { next: nil, prev: nil }, offset: 1, limit: 2, total: 5 }.as_json)
      end
    end
  end
end
