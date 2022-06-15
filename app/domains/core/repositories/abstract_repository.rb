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

  def paginate! pagy, response, count: nil
    if response.is_a? Array
      after  = (Base64.strict_encode64(response.last&.created_at&.to_datetime&.utc.to_f.round(3).to_s) rescue nil)
      before = (Base64.strict_encode64(response.first&.created_at&.to_datetime&.utc.to_f.round(3).to_s) rescue nil)
    else
      after  = (Base64.strict_encode64(response.results.results.last.created_at.to_datetime.utc.to_f.round(3).to_s) rescue nil)
      before = (Base64.strict_encode64(response.results.results.first._source.created_at.to_datetime.utc.to_f.round(3).to_s) rescue nil)
    end
    pages = {
      offset: pagy.page,
      total:  (count.present? ? count : pagy.count),
      limit:  pagy.items,
      cursor: {
        next: after,
        prev: before
      }
    }
    Core::Builders::Pagination.new(Builder::Model.new(pages)).build
  end
end
