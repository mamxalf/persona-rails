class MemberController < ApplicationController
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
  end

  def create
  end
end
