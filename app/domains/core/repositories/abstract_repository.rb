class Core::Repositories::AbstractRepository
  include Dry::Monads[:result]
  # include Core::Repositories::HttpMethods

  # Returns comma-separated error messages of the record
  #
  # @param [ActiveRecord::Base] record
  #
  # @return [String] Error messages
  def error_messages_for(record)
    record.errors.to_a.join(', ')
  end

  def prepare!(params, sanitize: true)
    if sanitize
      Hashie::Mash.new(params.reject { |_, v| v.nil? || (v.is_a?(String) && v.blank?) })
    else
      Hashie::Mash.new(params)
    end
  end

  def parse_response(response)
    return Failure Hashie::Mash.new(JSON.parse(response.body)) unless %w[200 201 202].include?(response.code.to_s)

    Success Hashie::Mash.new(JSON.parse(response.body))
  end

  def parse_response_csv(response)
    return Failure Hashie::Mash.new(JSON.parse(response.body)) unless %w[200 201 202].include?(response.code.to_s)

    Success response.body
  end
end
