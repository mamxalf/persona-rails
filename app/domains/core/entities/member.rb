class Core::Entities::Member < Core::Entities::AbstractEntity
  attribute :email, Types::Strict::String
  attribute :password, Types::Strict::String.optional
  attribute :role, Types::String.enum('user', 'admin', 'super_admin', 'trial')
  attribute :subscription, Types::Params::Date
end
