class RecommendationsController < ApplicationController
  
  before_action :authenticate, only: :index
  
  def options
    render nothing: true, status: :ok
  end
  
  def index
    # The only thing we need is the user token
    # token = token_and_options(request).first
    
    token = request.authorization.split("=").last
    @user = User.find_by_token token
    
    render nothing: true, status: 401 and return if token.nil?
    render nothing: true, status: 422 and return if params[:product_id].nil?
    
    answers = User.quiz_answers_by_token.startkey([token]).endkey([token, {}]).rows
    render nothing: true, status: 422 if answers.count != 7 # We don't have enough data to make recommendations
    
		packing1 = answers[0].value["answer_number"]+1
		packing2 = answers[1].value["answer_number"]+5
		packing3 = answers[2].value["answer_number"]+9
		packing4 = answers[3].value["answer_number"]+13
		packing5 = answers[4].value["answer_number"]+17
		packing6 = answers[5].value["answer_number"]+21
		packing7 = answers[6].value["answer_number"]+25
    
    if packing1-1 == 0
      packingAnswer1 = "a"
    elsif packing1-1 == 1
      packingAnswer1 = "b"
    elsif packing1-1 == 2
      packingAnswer1 = "c"
    else
      packingAnswer1 = "d"
    end
    
    if packing2-1 == 4
      packingAnswer2 = "a"
    elsif packing2-1 == 5
      packingAnswer2 = "b"
    elsif packing2-1 == 6
      packingAnswer2 = "c"
    else
      packingAnswer2 = "d"
    end
      
    if packing3-1 == 8
      packingAnswer3 = "a"
    elsif packing3-1 == 9
      packingAnswer3 = "b"
    elsif packing3-1 == 10
      packingAnswer3 = "c"
    else
      packingAnswer3 = "d"
    end
      
    if packing4-1 == 12
      packingAnswer4 = "a"
    elsif packing4-1 == 13
      packingAnswer4 = "b"
    elsif packing4-1 == 14
      packingAnswer4 = "c"
    else
      packingAnswer4 = "d"
    end
      
    if packing5-1 == 16
      packingAnswer5 = "a"
    elsif packing5-1 == 17
      packingAnswer5 = "b"
    elsif packing5-1 == 18
      packingAnswer5 = "c"
    else
      packingAnswer5 = "d"
    end
      
    if packing6-1 == 20
      packingAnswer6 = "a"
    elsif packing6-1 == 21
      packingAnswer6 = "b"
    elsif packing6-1 == 22
      packingAnswer6 = "c"
    else
      packingAnswer6 = "d"
    end
      
    if packing7-1 == 24
      packingAnswer7 = "a"
    elsif packing7-1 == 25
      packingAnswer7 = "b"
    elsif packing7-1 == 26
      packingAnswer7 = "c"
    else
      packingAnswer7 = "d"
    end  
      
    if params[:product_id] == "1"
      filter = "red"
    elsif params[:product_id] == "2"
      filter = "white"
    else
      filter = ""
    end
    
    url = "http://whispering-falls-1789.herokuapp.com/cases/p/q30/#{packingAnswer1}#{packing1}/q31/#{packingAnswer2}#{packing2}/q32/#{packingAnswer3}#{packing3}/q33/#{packingAnswer4}#{packing4}/q34/#{packingAnswer5}#{packing5}/q35/#{packingAnswer6}#{packing6}/q36/#{packingAnswer7}#{packing7}.json?filter=#{filter}&uuid=#{@user.uuid}"
    
    response = HTTParty.get(url)
    
    render nothing: true, status: 400 and return if response.code != 200

    render json: response

  end
  
  def auto_generate
    @user = Transaction.all_transactions.key(params[:user_id]).first
    
    # Guard against invalid users
    render nothing: true, status: 412 unless @user
    
    # Get url for recommendations
    
    answers = User.quiz_answers_by_token.startkey([@user.token]).endkey([@user.token, {}]).rows
    render nothing: true, status: 422 if answers.count != 7 # We don't have enough data to make recommendations
    
		packing1 = answers[0].value["answer_number"]+1
		packing2 = answers[1].value["answer_number"]+5
		packing3 = answers[2].value["answer_number"]+9
		packing4 = answers[3].value["answer_number"]+13
		packing5 = answers[4].value["answer_number"]+17
		packing6 = answers[5].value["answer_number"]+21
		packing7 = answers[6].value["answer_number"]+25
    
    if packing1-1 == 0
      packingAnswer1 = "a"
    elsif packing1-1 == 1
      packingAnswer1 = "b"
    elsif packing1-1 == 2
      packingAnswer1 = "c"
    else
      packingAnswer1 = "d"
    end
    
    if packing2-1 == 4
      packingAnswer2 = "a"
    elsif packing2-1 == 5
      packingAnswer2 = "b"
    elsif packing2-1 == 6
      packingAnswer2 = "c"
    else
      packingAnswer2 = "d"
    end
      
    if packing3-1 == 8
      packingAnswer3 = "a"
    elsif packing3-1 == 9
      packingAnswer3 = "b"
    elsif packing3-1 == 10
      packingAnswer3 = "c"
    else
      packingAnswer3 = "d"
    end
      
    if packing4-1 == 12
      packingAnswer4 = "a"
    elsif packing4-1 == 13
      packingAnswer4 = "b"
    elsif packing4-1 == 14
      packingAnswer4 = "c"
    else
      packingAnswer4 = "d"
    end
      
    if packing5-1 == 16
      packingAnswer5 = "a"
    elsif packing5-1 == 17
      packingAnswer5 = "b"
    elsif packing5-1 == 18
      packingAnswer5 = "c"
    else
      packingAnswer5 = "d"
    end
      
    if packing6-1 == 20
      packingAnswer6 = "a"
    elsif packing6-1 == 21
      packingAnswer6 = "b"
    elsif packing6-1 == 22
      packingAnswer6 = "c"
    else
      packingAnswer6 = "d"
    end
      
    if packing7-1 == 24
      packingAnswer7 = "a"
    elsif packing7-1 == 25
      packingAnswer7 = "b"
    elsif packing7-1 == 26
      packingAnswer7 = "c"
    else
      packingAnswer7 = "d"
    end  
      
    if params[:product_id] == "1"
      filter = "red"
    elsif params[:product_id] == "2"
      filter = "white"
    else
      filter = ""
    end
    
    url = "http://whispering-falls-1789.herokuapp.com/cases/p/q30/#{packingAnswer1}#{packing1}/q31/#{packingAnswer2}#{packing2}/q32/#{packingAnswer3}#{packing3}/q33/#{packingAnswer4}#{packing4}/q34/#{packingAnswer5}#{packing5}/q35/#{packingAnswer6}#{packing6}/q36/#{packingAnswer7}#{packing7}.json?filter=#{filter}&uuid=#{@user.uuid}"
    
    response = HTTParty.get(url)
    
    
    # Create wines for each wine
    response["wines"].each do |wine|
      @wine = Wine.new
      @wine.uuid = Digest::SHA1.hexdigest([Time.now, rand].join)
      @wine.wine_id = wine["wine_id"]
      @wine.wine_name = wine["name"]
  
      @user.wines << @wine
    end
    
    @user.save
    
    render nothing: true, status: 204
  end
end