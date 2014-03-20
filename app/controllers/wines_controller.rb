class WinesController < ApplicationController
  
  before_action :authenticate, except: [:options, :create, :destroy]
  before_action :authenticate_admin, only: [:create, :destroy]
  
  def create
    
    @user = Transaction.all_transactions.key(params[:user_id]).first
    
    if params[:wines]
      # Bulk
      params[:wines].each do |wine|
        
        render nothing: true, status: :unprocessable_entity and return if wine["wine_id"].nil? or wine["wine_name"].nil?
        
        @wine = Wine.new
        @wine.uuid = Digest::SHA1.hexdigest([Time.now, rand].join)
        @wine.wine_id = wine["wine_id"]
        @wine.wine_name = wine["wine_name"]
    
        @user.wines << @wine
      end
      
      @user.save
      
    elsif !params[:wine_id].nil? and !params[:wine_name].nil?    
      @wine = Wine.new
      @wine.uuid = Digest::SHA1.hexdigest([Time.now, rand].join)
      @wine.wine_id = params[:wine_id]
      @wine.wine_name = params[:wine_name]
    
      @user.wines << @wine
      @user.save
    else
      render nothing: true, status: :unprocessable_entity and return
    end

  end
  
  def index
    @wines = @user.wines
  end
  
  def update
    if params[:id] == nil
      uuid = params[:wine_id]
    else
      uuid = params[:id]
    end
    
    @wine = nil
    
    @user.wines.each { |wine|
      if wine.uuid == uuid
        wine.wine_name = params[:wine_name] unless params[:wine_name].nil?
        wine.wine_id = uuid unless uuid.nil?
        wine.rating = params[:rating] unless params[:rating].nil?
        wine.comment = params[:comment] unless params[:comment].nil?
        
        unless params[:rating].nil?
          url = "http://whispering-falls-1789.herokuapp.com/ratings/create?uuid=#{@user.uuid}&wine_id=#{wine.wine_id}&rating=#{wine.rating}"
          
          response = HTTParty.post(url)
          debugger
        end
        
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
