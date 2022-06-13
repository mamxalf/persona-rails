# frozen_string_literal: true

require 'rails_helper'
RSpec.describe Core::Repositories::Ping do
  describe '#result' do
    context 'when call ping' do
      let(:result) do
        described_class.new(message: 'ping').call
      end
      let(:result_resource) do
        described_class.new(message: 'ping').call as: :resources
      end
      it 'successfully response monad' do
        expect(result.success?).to be true
        expect(result.success.class).to eq(Core::Entities::Ping)
        expect(result.success.attributes).to eq({ message: 'pong' })
      end
      it 'successfully  response resource' do
        expect(result_resource.success?).to be true
        expect(result_resource.success.class).to eq(Hash)
        expect(result_resource.success).to eq({ message: 'pong' })
      end
    end
  end
end
