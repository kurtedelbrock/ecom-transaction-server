class UsersController < ApplicationController
	
	protect_from_forgery :except => :create
	
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
	
end
