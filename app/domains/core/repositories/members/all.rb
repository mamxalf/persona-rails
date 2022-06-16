require 'pagy'
class Core::Repositories::Members::All < Core::Repositories::AbstractRepository
  include Pagy::Backend
  def initialize(params)
    @params = prepare! params, sanitize: true
  end

  def call as: :builder
    members = Member.where(user_id: @params.user_id)
    return Failure 'Members not found' if members.blank?
    auths = Auth.where(auth_able_type: 'Member', auth_able_id: members.pluck(:id)).index_by(&:auth_able_id)
    return Failure 'Auth Not Found' if auths.blank?
    pagy, results = pagy(members, page: @params.offset, items: @params.limit)

    build_responses = results.map do |res|
      auth = auths[res.id]
      next if auth.nil?
      response as, { id: res.id, email: auth.email, password: nil, role: auth.role, is_active: res.is_active, subscription: res.subscription }
    end
    Success Hashie::Mash.new(response: build_responses.compact, pagination: (paginate! pagy, results))
  rescue => e
    Failure e.to_s
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
    Core::Builders::Member.new(Builder::Model.new(resources)).build
  end
end
