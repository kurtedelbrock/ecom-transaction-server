require 'bcrypt'

class AccountsController < ApplicationController
  
  protect_from_forgery :except => [:create, :options, :login, :admin_login]
  skip_before_filter :authenticate, only: [:create, :options, :login]
  
  def create
    debugger
    @user = User.new(params)
    @user.token = SecureRandom.hex
    
    @user.password = BCrypt::Password.create params[:password] if @user.password

    if !@user.save
      render nothing: true, status: :internal_server_error
    end
  end
  
  def login
    if params[:email].blank? or params[:password].blank?
      render nothing: true, status: :unprocessable_entity and return
    end
    
    @user = User.find_by_email(params[:email])
    
    render nothing: true, status: :internal_server_error and return if !@user
    
    if (!BCrypt::Password.new(@user.password).is_password? params[:password])
      render nothing: true, status: :internal_server_error and return
    end
    
  end
  
  def options
    render nothing: true, status: :ok
  end
  
  def admin_login
    if params[:email] == "admin@winesimple.com" and params[:password] == "Win35impl3!"
      render json: {token: "0dBhH1x5PQKmYTxDQDlKlOF0/Us4u7+NSH5+KLTJupc="}
    else
      render nothing: true, status: :internal_server_error
    end
  end
  
end
