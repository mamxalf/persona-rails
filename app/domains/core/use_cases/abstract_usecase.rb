class Core::UseCases::AbstractUsecase < CleanArchitecture::UseCases::AbstractUseCase
  def self.pagination_schema
    Dry::Schema.Params do
      optional(:searchable).filled(:string)
      optional(:offset).maybe(:integer)
      optional(:limit).maybe(:integer)
      optional(:query).maybe(:integer)
    end
  end
end
