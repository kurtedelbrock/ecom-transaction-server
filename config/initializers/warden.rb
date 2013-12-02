Rails.configuration.middleware.insert_after AuthParser, Warden::Manager do |manager|
  
  # define failure app
  manager.failure_app = UnauthorizedController
  
  # define default scope
  manager.default_scope = :unregistered
  
  # define scope defaults
  manager.scope_defaults :unregistered, :strategies => [:uuid]
  manager.scope_defaults :registered, :strategies => [:token]
  manager.scope_defaults :admin, :strategies => [:token, :membership]
  
end

Warden::Strategies.add(:uuid) do
  
  def valid?
    env['AUTHORIZATION_TYPE'] == "uuid" and env['AUTHORIZATION_TOKEN']
  end
  
  def authenticate!
    user = User.find_by_uuid env['AUTHORIZATION_TOKEN']
    user.nil? ? fail!("uuid") : success!(user)
  end
  
end

Warden::Strategies.add(:token) do
  
  def valid?
    env['AUTHORIZATION_TYPE'] == "token" and env['AUTHORIZATION_TOKEN']
  end
  
  def authenticate!
    fail!("token")
  end
  
end

Warden::Strategies.add(:membership) do
  
  def valid?
    true
  end
  
  def authenticate!
    fail!("admin")
  end
  
end