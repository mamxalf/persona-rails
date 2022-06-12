class Core::Repositories::Ping < Core::Repositories::AbstractRepository
  def initialize(message:)
    @message = message
  end

  def call as: :builder
    @message = if @message.eql?('ping')
      'pong'
    elsif @message.eql?('pong')
      'ping'
    else
      "'#{@message}' not valid message, must 'ping' or 'pong' message!"
    end
    return failure @message unless ['ping', 'pong'].include?(@message)
    Success response as, { message: @message }
  end

  private

  def response as, resources
    if as.to_s.eql?('resources')
      # bisa berupa model jika views butuh models response
      resources
    else
      builder resources
    end
  end

  def builder(resources)
    Core::Builders::Ping.new(Builder::Model.new(resources)).build
  end
end
