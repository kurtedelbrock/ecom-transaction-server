class TagsController < ApplicationController
  
  before_action :authenticate, except: [:options]
  
  def index
    @wine = @user.find_wine_by_id params[:wine_id]
    render json: @wine.tags
  end
  
  def create
    @tags = nil
    @user.wines.select do |wine|
      if wine.uuid == params[:wine_id]
        wine.tags << params[:tag]
        @tags = wine.tags
      end
    end
    
    @user.save
    
    render json: @tags
    
  end
  
  def destroy
    @tags = nil
    @user.wines.select do |wine|
      if wine.uuid == params[:wine_id]
        tags = wine.tags.select do |tag|
          tag != params[:id]
        end
        wine.tags = tags
        @tags = wine.tags
      end
    end
    
    @user.save
    
    render json: @tags
  end
  
  def options
    render nothing: true, status: :ok 
  end
  
end