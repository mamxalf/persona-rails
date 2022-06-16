class MembersController < ApplicationController
  def index
    # build params
    params.permit!
    params[:user_id] = current_auth.auth_able_id
    params[:limit] = params[:limit].present? ? params[:limit] : 10
    params[:offset] = params[:offset].present? ? params[:offset] : 1

    # to interactor
    interactor = Core::UseCases::Members::UserGetMembers
    parameters = interactor.parameters(params.to_hash)
    result     = interactor.new(parameters).result

    # build response
    @response = Dry::Matcher::ResultMatcher.call(result) do |matcher|
      yield matcher if block_given?
      matcher.success { |response| response_success({ members: response[:response], pagination: response[:pagination] }) }
      matcher.failure { |errors| { status: errors || :error } }
    end
  end

  def new
    @member = Member.new
  end

  def create
    parameters = member_params
    parameters[:user_id] = current_auth.auth_able_id
    parameters[:is_active] = true
    parameters[:subscription] = build_subscription member_params[:subscription]

    # to interactor
    interactor = Core::UseCases::Members::UserCreateNewMember
    parameters = interactor.parameters(parameters.to_hash)
    result     = interactor.new(parameters).result

    # build response
    @response = Dry::Matcher::ResultMatcher.call(result) do |matcher|
      yield matcher if block_given?
      matcher.success do |response|
        redirect_to action: 'show', id: response.id
      end
      matcher.failure do |errors|
        redirect_to members_path, alert: errors.to_s
      end
    end
  end

  def show
    params.permit!
  end

  private

  # Only allow a list of trusted parameters through.
  def member_params
    params.require(:member).permit(:email, :password, :subscription)
  end

  def build_subscription params
    case params
    when 'trial'
      Time.now + 1.day
    when 'one_month'
      Time.now + 30.day
    when 'one_year'
      Time.now + 365.day
    else
      Time.now + 1.day
    end
  end
end
