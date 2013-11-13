class QuizAnswersController < ApplicationController
  # users/:user_id/quiz_answers/:question_id
  
  def update    
    index = @user.quiz_answers.find_index { |answer|
      answer.question_number == params[:question_number]
    }
    
    if index.nil?
      @answer = QuizAnswer.new(params)
      @user.quiz_answers << @answer
    else
      @answer = @user.quiz_answers[index]
      @answer.question_number = params[:question_number]
      @answer.answer_number = params[:answer_number]
      @user.quiz_answers[index] = @answer
    end
    
    if !@user.save
      render nothing: true, status: :internal_server_error
    end
  end
  
end
