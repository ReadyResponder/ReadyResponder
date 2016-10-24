Rails.application.routes.draw do
  resources :notifications
  resources :availabilities
  resources :unique_ids

  resources :item_types

  resources :resource_types
  resources :messages
  resources :activities
  resources :helpdocs
  resources :channels
  resources :departments
  resources :timecards
  resources :roles

  post 'events/:id/schedule/:person_id/:card_action', to: 'events#schedule', as: 'schedule'

  resources :moves
  resources :locations

  resources :repairs
  resources :inspections, except: [:new, :create], constraints: { id: /\d+/ }
  resources :items do
    resources :repairs
    resources :inspections, only: [:new, :create]
  end

  get 'landing/help', as: 'help', path: '/help'

  devise_for :users
  resources :users

  resources :titles
  resources :skills
  resources :courses
  resources :certs

  resources :requirements, except: [:new, :create], constraints: { id: /\d+/ }

  resources :tasks, except: [:new, :create], constraints: { id: /\d+/ } do
    resources :requirements, only: [:new, :create]
  end

  resources :events do
    resources :tasks, only: [:new, :create]
    resources :availabilities
  end

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
    resources :certs
    resources :availabilities
    resources :titles
    resources :items
    resources :channels
  end

  root "landing#index"

end
