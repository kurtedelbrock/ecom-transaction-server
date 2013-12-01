class UuidController < ApplicationController
  skip_before_filter :authenticate, only: [:show]
  
  def show
    render json: {uuid: SecureRandom.uuid}
  end
end
