class AuthParser
  def initialize(app)
    @app = app
  end
  
  def call(env)
    if !env['HTTP_AUTHORIZATION'].nil?
      env['AUTHORIZATION_TYPE'], env['AUTHORIZATION_TOKEN'] = env['HTTP_AUTHORIZATION'].split(" ").last.split("=")
    end
    @app.call(env)
  end
end