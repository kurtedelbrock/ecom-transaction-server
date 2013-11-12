class UsersController < ApplicationController
	
protect_from_forgery :except => [:create, :update]
	
	def index
		@users = User.list.all
	end
	
	def show
	  @user = User.get(params[:id])
  end
  
  def create
	  @user = User.new(params)
	  @user.save
	end
	
	def update
		@user = User.get(params[:id])
		@user.update_attributes(params)
  end
	
	def destroy
		
	end
	
end
