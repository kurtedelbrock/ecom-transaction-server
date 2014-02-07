class WinesController < ApplicationController
  
  before_action :authenticate, except: [:options, :create, :destroy]
  before_action :authenticate_admin, only: [:create, :destroy]
  
  def create
    render nothing: true, status: :unprocessable_entity and return if params[:wine_id].nil? or params[:wine_name].nil?
    
    @user = Transaction.all_transactions.key(params[:user_id]).first
    
    @wine = Wine.new
    @wine.uuid = Digest::SHA1.hexdigest([Time.now, rand].join)
    @wine.wine_id = params[:wine_id]
    @wine.wine_name = params[:wine_name]
    
    @user.wines << @wine
    @user.save
  end
  
  def index
    @wines = @user.wines
  end
  
  def update
    uuid = params[:id]
    
    @wine = nil
    
    @user.wines.each { |wine|
      if wine.uuid == uuid
        wine.wine_name = params[:wine_name] unless params[:wine_name].nil?
        wine.wine_id = params[:wine_id] unless params[:wine_id].nil?
        wine.rating = params[:rating] unless params[:rating].nil?
        wine.comment = params[:comment] unless params[:comment].nil?
        
        @wine = wine
      end
    }
    
    @user.save
  end
  
  def destroy
    @user = Transaction.all_transactions.key(params[:user_id]).first
    uuid = params[:id]

    wines = @user.wines.select {|wine| wine.uuid != uuid}
    @user.wines = wines

    @user.save
    render nothing: true, status: :ok
  end
  
  def options
    render nothing: true, status: :ok
  end
end
