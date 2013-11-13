class BillingAddressController < ApplicationController
  
  def create
    @address = Address.new(params)
    @user.billing_address = @address
    @user.save
  end
  
  def destroy
    @user.billing_address = nil
    render nothing: true, status: :ok if @user.save
  end
  
end