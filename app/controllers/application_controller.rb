class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  
  private
  
  def authenticate
    authenticate_or_request_with_http_token do |token, options|
      @user = User.find_by_token token
      @user
    end
  end
  
end