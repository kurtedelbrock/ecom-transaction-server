class TransactionsController < ApplicationController
  
  def create
    @transaction = Transaction.new(params)
    @transaction.transaction_timestamp = DateTime.now
    @transaction.transaction_guid = SecureRandom.hex
    @user.transactions << @transaction
    @user.save
  end

  def destroy
    index = @user.transactions.find_index { |transaction| 
      transaction.transaction_guid == params[:id]
    }
    
    @user.transactions.delete_at index
    render nothing: true, status: :ok if @user.save
    
  end
  
end
