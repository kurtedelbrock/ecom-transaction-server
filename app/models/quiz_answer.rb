class QuizAnswer < CouchRest::Model::Base
	include CouchRest::Model::Embeddable
	
	property :question_number,				Integer
	property :answer_number, 				Integer # zero indexed?		
	
  timestamps!
	
end
