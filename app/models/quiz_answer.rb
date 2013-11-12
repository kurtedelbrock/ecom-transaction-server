class QuizAnswer < CouchRest::Model::Base
	include CouchRest::Model::Embeddable
	
	property :question_number,				Integer
	property :answer_number, 				Integer # zero indexed?
	
	property :object_type,						String, :default => "quiz_answer", :read_only => true				
	
  timestamps!
	
end
