class Core::UseCases::Ping < Core::UseCases::AbstractUsecase
  contract do
    params do
      required(:message).filled(:string)
    end
  end

  include Dry::Monads::Do.for(:result)
  def result
    params = yield result_of_validating_params
    Core::Repositories::Ping.new(message: params[:message]).call
  end
end
