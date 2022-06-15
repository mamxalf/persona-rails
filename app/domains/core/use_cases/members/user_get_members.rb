class Core::UseCases::Members::UserGetMembers < Core::UseCases::AbstractUsecase
  contract do
    params(Core::UseCases::AbstractUsecase.pagination_schema) do
      required(:user_id).filled(:string)
    end
  end

  include Dry::Monads::Do.for(:result)
  def result
    params = yield result_of_validating_params
    Core::Repositories::Members::All.new(params).call
  end
end
