class UsersController < ApplicationController
	
	def index
		@users = User.list.all
	end
	
end
