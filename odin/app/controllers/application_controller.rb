class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Basic::ControllerMethods

  before_action :authenticate_user!, unless: :devise_controller?

  attr_reader :current_user

  private

  def authenticate_user!
    authenticate_or_request_with_http_basic do |email, password|
      user = User.find_by(email: email)
      if user&.valid_password?(password)
        @current_user = user
      end
    end
  end
end
