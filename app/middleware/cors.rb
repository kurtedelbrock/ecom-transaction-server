class Cors
  def initialize(app)
    @app = app
  end

  def call(env)
    status, headers, response = @app.call(env)

    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Headers'] = 'Origin, X-Requested-With, Content-Type, Accept, Authorization'
    headers['Access-Control-Allow-Methods'] = 'DELETE, GET, HEAD, OPTIONS, POST, PUT'
    headers['Access-Control-Max-Age'] = "1728000"
    headers['Access-Control-Expose-Headers'] = 'X-Required-Role, Link'
  
    [status, headers, response]
  end
end