require 'bcrypt'

class AccountsController < ApplicationController
  
  protect_from_forgery :except => [:create]
  skip_before_filter :authenticate, only: [:create]
  
  def create
    
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
    
    render nothing: true, status: :unauthorized and return if !@user
    
    if (!BCrypt::Password.new(@user.password).is_password? params[:password])
      render nothing: true, status: :unauthorized and return
    end
    
  end
  
  def options
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, OPTIONS'
    headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-Prototype-Version'
    headers['Access-Control-Max-Age'] = '1728000'
    render :text => '', :content_type => 'text/plain'
  end
  
end
