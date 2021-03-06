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
  
  def authenticate_admin
    authenticate_or_request_with_http_token do |token, options|
      token == "0dBhH1x5PQKmYTxDQDlKlOF0/Us4u7+NSH5+KLTJupc="
    end
  end
  
end