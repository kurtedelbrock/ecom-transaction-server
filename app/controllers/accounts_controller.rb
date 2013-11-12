class AccountsController < ApplicationController
  
  protect_from_forgery :except => [:create]
  
  def create
    @user = User.new(params)
    @user.token = SecureRandom.hex

    if !@user.save
      render nothing: true, status: :internal_server_error
    end
  end
  
  def login
    if params[:email].blank? or params[:password].blank?
      render nothing: true, status: :unprocessable_entity and return
    end
    
  end
  
end
