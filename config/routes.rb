Rails.application.routes.draw do
  
  namespace :users_backoffice do
    get 'welcome/index'
    get 'profile', to: 'profile#edit'
  end
  namespace :site do
    get  'welcome/index'
    get  'search', to: 'search#questions'
    get  'subject/:subject_id', to: 'search#subject', as: 'search_subject'
    post 'answer', to: 'answer#question'
  end
 namespace :admins_backoffice do
    get 'welcome/index' # Dashboard
    resources :admins
    resources :subjects
    resources :questions
  end
  
  devise_for :users
  devise_for :admins, skip: [:registrations]
  
  
  get 'inicio', to: 'site/welcome#index '
  
  root to: 'site/welcome#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
