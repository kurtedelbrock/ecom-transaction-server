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

Warden::Manager.serialize_into_session do |user|
  nil
end

Warden::Manager.serialize_from_session do |id|
  nil
end

Warden::Strategies.add(:uuid) do
  
  def authenticate!
    if env['AUTHORIZATION_TYPE'] != "uuid" or env['AUTHORIZATION_TOKEN'] == nil
      fail!("uuid") and return
    end
    user = User.by_uuid.key(env['AUTHORIZATION_TOKEN']).first

    if user.nil?
      fail!("uuid") and return
    else
      success!(user)
    end
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