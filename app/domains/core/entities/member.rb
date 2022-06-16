class Core::Entities::Member < Core::Entities::AbstractEntity
  attribute :id, Types::Strict::String
  attribute :email, Types::Strict::String
  attribute :password, Types::Strict::String.optional
  attribute :role, Types::String.enum('user', 'admin', 'super_admin', 'trial')
  attribute :is_active, Types::Strict::Bool
  attribute :subscription, Types::Params::Date
end
