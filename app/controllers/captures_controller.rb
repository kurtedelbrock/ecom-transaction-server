class CapturesController < ApplicationController
  def create
    gb = Gibbon::API.new("11898c323ef2a077e7d528e83912e3ba-us3")
    @response = gb.lists.subscribe({id: "5f8582abe9", email: {email: params[:email]}, merge_vars: {groupings: [name: "State", groups: [params[:state]]]}, double_optin: false})
    
    render json: @response
  
  end
  
  def options
    render nothing: true, status: :ok
  end
end