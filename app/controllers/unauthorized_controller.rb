class UnauthorizedController < ApplicationController
  
  def self.call(env) # Sets up a Rack endpoint for this controller
    @respond ||= action(:respond)
    @respond.call(env) # Reroutes all calls to the respond method
  end
  
  def respond
    puts env["warden"].message
    if env["warden"].message == "uuid"
      response.headers["X-Required-Role"] = "unregistered"
      response.headers["Link"] = '</users>; rel="authentication"; method="POST"'
      render nothing: true, status: :unauthorized and return
    elsif env["warden"].message == "token"
      response.headers["X-Required-Role"] = "registered"
      response.headers["Link"] = '</users/login>; rel="authentication"; method="POST"'
      render nothing: true, status: :unauthorized and return
    elsif env["warden"].message == "admin"
      render nothing: true, status: :not_found and return
    end
  end
  
end