class BillingAddressController < ApplicationController
  
  def create
    @address = Address.new(params)
    @user.billing_address = @address
    @user.save
  end
  
end