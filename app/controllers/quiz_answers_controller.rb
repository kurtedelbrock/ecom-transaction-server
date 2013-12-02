class QuizAnswersController < ApplicationController
  # users/:user_id/quiz_answers/:question_id
  
  def create
    # do authentication
    env['warden'].authenticate! :scope => :unregistered
    @user = env['warden'].user
    
    # map params
    question_number = params[:question_number]
    answer_number = params[:answer_number]
    
    # validate that the quiz question and quiz answer exist in the request
    render nothing: true, status: :bad_request and return if question_number == nil && answer_number == nil
    
    # see if we already have this question
    index = @user.quiz_answers.find_index { |answer|
      answer.question_number == question_number
    }
    
    if index.nil? # if not, add it
      @answer = QuizAnswer.new(params)
      @user.quiz_answers << @answer
    else # if so, update it
      @answer = @user.quiz_answers[index]
      @answer.question_number = question_number
      @answer.answer_number = answer_number
      @user.quiz_answers[index] = @answer
    end

    render nothing: true, status: :internal_server_error if !@user.save
  end
  
end
