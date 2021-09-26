Rails.application.routes.draw do
  resources :item_categories do
    resources :item_types
  end

  resources :vendors

  resources :people do
    collection do
      get 'inactive'
      get 'everybody'
      get 'applicants'
      get 'signin'
    end
    resources :certs
    resources :availabilities
    resources :timecards
    resources :titles
    resources :items
    resources :channels
  end

  resources :recipients, except: [:index]
  resources :settings
  resources :notifications
  resources :availabilities
  resources :unique_ids

  resources :item_types do
    resources :items
  end

  resources :resource_types
  resources :messages
  resources :activities
  resources :helpdocs, only: [:show, :index]
  resources :channels
  resources :departments do
    collection do
      get 'orgchart/:id', action: "orgchart", as: :orgchart
    end
  end
  resources :timecards

  resources :timecards do
    post 'verify'
  end
  resources :roles

  post 'events/:id/schedule/:person_id/:card_action',
        to: 'events#schedule', as: 'schedule'

  post 'texts/receive_text', to: 'texts#receive_text'
  post 'say_voice', to: 'texts#say_voice'

  resources :moves
  resources :locations

  resources :repairs
  resources :inspections, except: [:new, :create], constraints: { id: /\d+/ }
  resources :items do
    resources :repairs
    resources :inspections, only: [:new, :create]
  end
  resources :grants

  get '/uploads/item/item_image/:id/:basename.:extension', controller: 'items', action: 'download', type: 'item_image'
  get '/uploads/item_type/item_type_image/:id/:basename.:extension', controller: 'item_types', action: 'download', type: 'item_type_image'
  get '/uploads/person/portrait/:id/:basename.:extension', controller: 'people', action: 'download', type: 'portrait'
  get '/uploads/cert/certification/:id/:basename.:extension', controller: 'certs', action: 'download', type: 'certification'

  get 'landing/help', as: 'help', to: 'landing#help'

  devise_for :users
  resources :users

  resources :titles
  resources :skills
  resources :courses
  resources :certs

  resources :analytics, except: [:new, :create, :show, :index, :edit, :update, :destroy] do
    get 'calendar_chart', on: :collection
    get 'system_activity_logs', on: :collection
  end

  get 'events/templates', to: 'events#templates'
  get 'events/archives', to: 'events#archives'

  resources :events do
    resources :tasks, only: [:new, :create]
    resources :availabilities
    resources :notifications
  end

  resources :tasks, except: [:new, :create], constraints: { id: /\d+/ } do
    resources :requirements, only: [:new, :create]
  end

  resources :requirements, except: [:new, :create], constraints: { id: /\d+/ } do
    resources :assignments, only: [:new, :create, :edit, :update]
  end

  resources :assignments, except: [:new, :create], constraints: { id: /\d+/ }

  resources :comments, only: [:create]

  root "landing#index"

end
