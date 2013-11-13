class ShippingAddressController < ApplicationController
  
  def create
    @address = Address.new(params)
    @user.shipping_address = @address
    @user.save
  end
  
  def destroy
    @user.shipping_address = nil
    render nothing: true, status: :ok if @user.save
  end
  
end
