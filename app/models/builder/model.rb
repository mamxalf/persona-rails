class Builder::Model < Hashie::Mash
  def initialize(params)
    params.each_pair do |k, v|
      self[k] = v
    end
    @attributes = params
  end

  def attributes
    ActiveSupport::HashWithIndifferentAccess.new(@attributes).symbolize_keys
  end
end
