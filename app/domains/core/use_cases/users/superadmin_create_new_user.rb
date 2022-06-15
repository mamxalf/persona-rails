class Core::UseCases::Users::SuperadminCreateNewUser < Core::UseCases::AbstractUsecase
  contract do
    params(Core::UseCases::AbstractUsecase.user_schema) do
    end
  end

  include Dry::Monads::Do.for(:result)
  def result
    params = yield result_of_validating_params
    Core::Repositories::Users::Create.new(params).call
  end
end
