Rails.application.routes.draw do
  resources :unique_ids


  resources :item_types


  resources :resource_types
  resources :messages
  resources :activities
  resources :helpdocs
  resources :channels
  resources :departments
  resources :timecards
  resources :events
  resources :roles

  post 'events/:id/schedule/:person_id/:card_action', to: 'events#schedule', as: 'schedule'

  resources :moves
  resources :repairs
  resources :locations
  resources :items do
    resources :repairs, :controller => 'repairs'
    resources :inspections, :controller => 'inspections'
  end

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

  root "landing#index"

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
