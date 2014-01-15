class TransactionsController < ApplicationController
  
  def index
    @transactions = Transaction.all_transactions.rows
  end
  
  def create
    
    # Assume that we'll receive the product id and the 
    
    product = Product.for_id params[:product_id]
    
    
    if product.charge params[:stripe_token]
      # The card was successfully charged, so add the transaction to the database
      
    end
    
    render nothing: true
    
    # # do authentication for uuid scope
    # env['warden'].authenticate! :scope => :unregistered
    # @user = env['warden'].user
    # 
    # # Bail out if @user validation fails
    # render nothing: true, status: :unprocessable_entity and return if !@user.validate_for_transaction params
    # 
    # # Perform validation and update model data
    # @user.update_from_transaction! params
    # 
    # # Perform password hashing and token generation
    # @user.generate_password! params[:password]
    # @user.generate_token!
    # 
    # # Create transaction object
    # @transaction = Transaction.populate_with_automatic_data
    # @transaction.product_id = params[:product_id]
    # 
    # # Append the transaction object to the document
    # @user.transactions << @transaction
    # debugger
    # @user.save
  end

  def destroy
    index = @user.transactions.find_index { |transaction| 
      transaction.transaction_guid == params[:id]
    }
    
    @user.transactions.delete_at index
    render nothing: true, status: :ok if @user.save
  end
  
  def options
    render nothing: true, status: :ok
  end
  
end
