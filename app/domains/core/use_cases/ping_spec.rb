# frozen_string_literal: true

require 'rails_helper'
RSpec.describe Core::UseCases::Ping do
  describe '#result' do
    context 'when call ping' do
      let(:result) do
        Core::UseCases::Ping.new(Core::UseCases::Ping.parameters({ message: 'ping' })).result
      end
      it 'successfully created' do
        allow_any_instance_of(Core::Repositories::Ping).to receive(:call).and_return(Success({ message: 'pong' }))
        expect(result.success?).to be true
        expect(result.success.as_json).to eq({ message: 'pong' }.as_json)
      end
    end
  end
end
