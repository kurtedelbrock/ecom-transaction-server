class UsersController < ApplicationController
	
protect_from_forgery :except => [:create, :update, :destroy]
skip_before_filter :authenticate, only: [:index, :create]
	
	def index
		@users = User.list.all
	end
	
	def show
	  @user = User.get(params[:id])
  end
  
  def create
	  @user = User.new

    @user.token = SecureRandom.uuid
    @user.uuid = SecureRandom.uuid
    @user.email = SecureRandom.uuid
    
	  @user.save
	end
	
	def update
		@user = User.get(params[:id])
		@user.update_attributes(params)
  end
	
	def destroy
		@user = User.get(params[:id])
    if @user.destroy
      render status: :ok, nothing: true
    else
      render status: :internal_server_error, nothing: true
    end
	end
  
  def options
    render nothing: true, status: :ok
  end
	
end
