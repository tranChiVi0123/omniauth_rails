class Api::V1::BaseController < ApplicationController
  # skip_before_action :verify_authenticity_token
  skip_before_action :authenticate_user! 
  before_action :authenticate_token!

  protected
  def unauthorized
    render json: { message: 'Unauthorized' }, status: :unauthorized
  end

  def user
    @user
  end

  private
  def authenticate_token!
    @user ||= User.find_by(uid: decode_auth_token[:uid]) if decode_auth_token
    render json: {message: "Unauthorized", status: 401} unless @user
  end

  def decode_auth_token
    @decode_auth_token ||= JsonWebToken.decode(http_auth_header)
  end

  def http_auth_header
    return request.headers['Authorization'].split(' ').last if request.headers['Authorization'].present?
  end
end