class ShippingAddressController < ApplicationController
  
  def create
    @address = Address.new(params)
    @user.shipping_address = @address
    @user.save
  end
  
end
