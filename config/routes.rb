Lims3::Application.routes.draw do
  resources :activities


  resources :helpdocs

  resources :channels

  resources :timecards

  resources :events

  resources :moves

  resources :repairs

  resources :locations

  resources :items do
    resources :repairs, :controller => 'repairs'
  end
  

  resources :roles

  get "landing/index"

  #authenticated :user do
  #  root :to => "people#index" 
  #end

  devise_for :users
  resources :users
  resources :inspections

  resources :titles

  resources :skills

  resources :courses

  resources :certs

  resources :people do
      collection do
	      get 'inactive'
        get 'leave'
        get 'other'
        get 'everybody'
        get 'applicants'
        get 'prospects'
        get 'declined'
        get 'cert'
        get 'police'
        get 'signin'
	      get 'orgchart'
        get 'roster'
      end
    resources :certs, :controller => 'certs'
    resources :titles, :controller => 'titles'
    resources :items, :controller => 'items'
    resources :channels, :controller => "channels"
  end

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'
#root :to => 'people/index'
  # See how all your routes lay out with "rake routes"
  root :to => "landing#index"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
