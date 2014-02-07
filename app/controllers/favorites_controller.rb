class FavoritesController < ApplicationController
  before_action :authenticate
  
  def create
    @user.favorite_wine = params[:favorite]
    @user.save
    
    render json: @user
  end
  
  def index
    render json: {"favorite_wine" => @user.favorite_wine}
  end
  
end