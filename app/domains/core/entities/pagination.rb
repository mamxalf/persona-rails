# frozen_string_literal: true

class Core::Entities::Pagination < Core::Entities::AbstractEntity
  attribute :cursor, Types::Strict::Hash
  attribute :offset, Types::Strict::Integer
  attribute :limit, Types::Strict::Integer
  attribute :total, Types::Strict::Integer
end
