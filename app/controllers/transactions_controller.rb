require 'mandrill'

class TransactionsController < ApplicationController
  
  before_action :authenticate, only: :create
  before_action :authenticate_admin, only: [:index]
  
  def index
    @transactions = Transaction.all_transactions.rows
  end
  
  def show
    @user = Transaction.all_transactions.key params[:id]
    @transaction = @user.first.transactions.find {|transaction| transaction.transaction_guid == params[:id]}
    @user = @user.first
  end
  
  def create
    
    # Assume that we'll receive the product id and the 
    puts params[:product_id]
    product = Product.for_id params[:product_id]
    product.price = params[:charge_price]
    
    @user.email = params[:email]
    
    unless @user.save
      render status: :internal_server_error and return
    end
      
    
    
    if charge = product.charge(params[:stripe_token])
      # The card was successfully charged, so add the transaction to the database
      
      @transaction = Transaction.populate_with_automatic_data
      
      @transaction.ingest_params params
      @transaction.charge = Charge.ingest_params charge
      
      # set email and password
      @user.email = params[:email]
      @user.password = BCrypt::Password.create params[:password]
      @user.token = Digest::SHA1.hexdigest([Time.now, rand].join)
      
      @user.transactions << @transaction
      @user.save
      
      # Send a confirmation email
      
      m = Mandrill::API.new "TL7k2OAn9CsrWwa_1eTDBA"
      n = Mandrill::API.new "TL7k2OAn9CsrWwa_1eTDBA"
      message = {
        to: [{
          email: @user.email,
          name: "#{@transaction.first_name} #{@transaction.last_name}",
          type: "to"
        }],
        bcc_address: "team@winesimple.com",
        merge: true,
        merge_vars: [
          {
            rcpt: @user.email,
            vars: [
              {
                name: "fname",
                content: @user.first_name
              }
            ]
          }
        ],
        tags: [
          "order-confirmation"
        ]
      }
      
      message2 = {  
       :subject=> "Alert: New Order",  
       :from_name=> "Your name",  
       :text=>"<html>#{@transaction.first_name} #{@transaction.last_name}</html>",  
       :to=>[  
         {  
           :email=> "team@winesimple.com",  
           :name=> "Recipient1"  
         }  
       ],  
       :html=>"<html>#{@transaction.first_name} #{@transaction.last_name}<br><br>#{@transaction}</html>"
      }  
      
      sending = m.messages.send_template("Order Confirmation", "", message)
      sending = n.messages.send(message2)
      
      render status: :internal_server_error and return unless @user.persisted?
      
    else
      render status: :internal_server_error
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
