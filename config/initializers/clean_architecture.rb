CleanArchitecture::UseCases::AbstractUseCase.instance_eval do
  def self.contract(base_contract = CleanArchitecture::UseCases::Contract, &proc)
    @contract ||= Class.new(base_contract, &proc)
  end
end
