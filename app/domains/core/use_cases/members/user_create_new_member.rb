class Core::UseCases::Members::UserCreateNewMember < Core::UseCases::AbstractUsecase
  contract do
    params(Core::UseCases::AbstractUsecase.user_schema) do
      required(:user_id).filled(:string)
      required(:is_active).filled(:bool)
      required(:subscription).filled(:time).default(Time.zone.now)
    end
  end

  include Dry::Monads::Do.for(:result)
  def result
    params = yield result_of_validating_params
    Core::Repositories::Members::Create.new(params).call
  end
end
