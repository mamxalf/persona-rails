class Core::Repositories::Users::Create < Core::Repositories::AbstractRepository
  def initialize(params)
    @params = prepare! params, sanitize: true
  end

  def call as: :builder
    user = User.new(@params.except(:password).as_json)
    user.build_auth(email: @params.email, password: @params.password, role: @params.role)

    # result
    return Failure error_messages_for(user) unless user.save
    Success response as, user
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
    Core::Builders::User.new(resources).build
  end
end
