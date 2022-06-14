class Core::Entities::User < Core::Entities::AbstractEntity
  attribute :full_name, Types::Strict::String
  attribute :email, Types::Strict::String
  attribute :address, Types::Strict::String
  attribute :phone_number, Types::Strict::String
end
