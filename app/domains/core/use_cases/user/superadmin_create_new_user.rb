class Core::UseCases::User::SuperadminCreateNewUser < Core::UseCases::AbstractUsecase
  contract do
    params do
      required(:full_name).filled(:string)
      required(:phone_number).filled(:string)
      required(:address).filled(:string)
      required(:email).filled(:string)
      required(:password).filled(:string)
      optional(:role).maybe(:string, included_in?: User.allowed_role).default('user')
    end
  end

  include Dry::Monads::Do.for(:result)
  def result
    params = yield result_of_validating_params
    Core::Repositories::Ping.new(message: params[:message]).call
  end
end
