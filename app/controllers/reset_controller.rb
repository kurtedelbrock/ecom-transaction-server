require 'mandrill'

class ResetController < ApplicationController
  def create
    
    params[:user_id].gsub! "+", "."
    debugger
    @user = User.find_by_email params[:user_id]
    
    # Guard for no user found
    render nothing: true, status: 204 and return unless @user
    
    # Set the reset password flag to true
    @user.reset_password = true
    
    # Guard that the database save worked
    render json: {error: "The database could not be contacted. Please try again and contact an administrator if the problem persists."}, status: 500 and return unless @user.save
    
    # Send the user an email
    m = Mandrill::API.new "TL7k2OAn9CsrWwa_1eTDBA"
    message = {
      to: [
        {email: params[:user_id], name: params[:user_id], type: "to"}
      ],
      merge: true,
      merge_vars: [
        {
          rcpt: params[:user_id], vars: [{name: "email", content: params[:user_id].gsub(".", "+")}]
        }
      ],
      tags: ["password-reset"]
    }
    
    debugger
    
    sending = m.messages.send_template("Reset Password", "", message)

    # Return an error code if the email send fails
    render json: {error: "The server could not send you an email with password reset instructions. Please email support if the problem persists."}, status: 500 and return unless sending
    
    # Successfully render a blank response
    render nothing: true, status: 204
    
  end
end