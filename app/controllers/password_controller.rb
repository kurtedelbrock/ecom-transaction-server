require 'bcrypt'

class PasswordController < ApplicationController
  def update
    
    params[:user_id].sub! "+", "."
    
    # Require a password parameter in the JSON to continue...
    render nothing: true, status: 422 and return unless params[:password]
    
    @user = User.find_by_email params[:user_id]
    
    # Guard for no user found
    render nothing: {error: "No valid user found to reset the password for."}, status: 412 and return unless @user
    
    # Guard against no reset password hash
    render json: {error: "No valid user found to reset the password for."}, status: 412 and return unless @user.reset_password
    
    # Create password hash, set it to the user, and save the user
    @user.password = BCrypt::Password.create params[:password]
    @user.reset_password = nil
    
    # Guard against failed save
    render nothing: true, status: 500 and return unless @user.save
    
    render nothing: true, status: 200
    
  end
end