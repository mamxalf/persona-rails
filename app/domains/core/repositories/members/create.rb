class Core::Repositories::Members::Create < Core::Repositories::AbstractRepository
  def initialize(params)
    @params = prepare! params, sanitize: true
  end

  def call as: :builder
    user = User.find_by(id: @params.user_id)
    return Failure 'User not Found' if user.nil?
    # build member
    member = user.members.create(is_active: @params.is_active, subscription: @params.subscription)

    # build auth
    password = Devise.friendly_token(10)
    auth = member.build_auth(email: @params.email, password: password, role: @params.role)
    return Failure error_messages_for(auth) unless auth.save

    # build response
    build_response = { id: member.id, email: auth.email, password: password, role: auth.role, is_active: member.is_active, subscription: member.subscription }

    # result
    Success response as, build_response
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
