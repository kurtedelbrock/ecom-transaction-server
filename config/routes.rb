EcomTransactionServer::Application.routes.draw do
	
  resources :wines, defaults: {format: :json} do
    resources :tags, defaults: {format: :json}
  end

  resources :accounts, defaults: {format: :json} do
    post 'login', on: :collection, defaults: {format: :json}
    # match 'login', on: :collection, :action => 'options', :via => :options
  end

  resources :captures, defaults: {format: :json}

	resources :users, defaults: {format: :json} do
    resources :favorites, defaults: {format: :json}
  end
  
  resources :billing_address, defaults: {format: :json}
  resources :shipping_address, defaults: {format: :json}
  resources :transactions, defaults: {format: :json}
  resources :recommendations, defaults: {format: :json}
  
  resources :quiz_answers, defaults: {format: :json}
  
  get 'uuid' => 'uuid#show'
  
  match '/recommendations', :controller => 'recommendations', :action => 'options', :via => :options
  match '/quiz_answers', :controller => 'quiz_answers', :action => 'options', :via => :options
  match '/users', :controller => 'users', :action => 'options', :via => :options
  match '/transactions', :controller => 'transactions', :action => 'options', :via => :options
  match '/captures', :controller => 'captures', :action => 'options', :via => :options
  match '/accounts', :controller => 'accounts', :action => 'options', :via => :options
  match '/tags', :controller => 'tags', :action => 'options', :via => :options
  match '/wines/:id/tags/:id', :controller => 'wines', :action => 'options', :via => :options
  match '/wines/:id/tags', :controller => 'wines', :action => 'options', :via => :options
  match '/users/:id/favorites', :controller => 'wines', :action => 'options', :via => :options
  match '/wines', :controller => 'wines', :action => 'options', :via => :options
  match '/wines/:id', :controller => 'wines', :action => 'options', :via => :options
  match '/transactions/:id', :controller => 'wines', :action => 'options', :via => :options
  match '/accounts/login', :controller => 'accounts', :action => 'options', :via => :options
  
  match '/accounts/admin/login', controller: 'accounts', action: 'admin_login', via: :post
  match '/accounts/admin/login', controller: 'accounts', action: 'options', via: :options
  
  # match "*all" => "application#cors_preflight_check", :constraints => { :method => "OPTIONS" }, :via => :options
	
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
