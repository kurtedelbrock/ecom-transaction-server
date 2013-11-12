class UsersController < ApplicationController
	
	def index
		@users = User.list.all
	end
	
	def show
		@user = User.get(params[:id])
	end
	
end
