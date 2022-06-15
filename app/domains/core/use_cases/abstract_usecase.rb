class Core::UseCases::AbstractUsecase < CleanArchitecture::UseCases::AbstractUseCase
  def self.pagination_schema
    Dry::Schema.Params do
      optional(:searchable).filled(:string)
      optional(:offset).maybe(:integer)
      optional(:limit).maybe(:integer)
      optional(:query).maybe(:integer)
    end
  end

  def self.user_schema
    Dry::Schema.Params do
      optional(:full_name).maybe(:string)
      optional(:phone_number).maybe(:string)
      optional(:address).maybe(:string)
      optional(:password).maybe(:string)
      required(:email).filled(:string)
      optional(:role).maybe(:string, included_in?: User.allowed_role).default('user')
    end
  end
end
