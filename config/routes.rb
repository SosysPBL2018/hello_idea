Rails.application.routes.draw do
  get 'mandalarts/index'
  post 'mandalarts/create' => 'mandalarts#create'
  root 'home#top'
  get '/detail' => 'home#detail'
  post 'topics/classfy_topic'
  get '/login' => 'users#login'
  post '/login' => 'users#check_user'
  get '/logout' => 'users#logout'
  
  resources :users, shallow: true do
    resources :notices, except: :create
  end
  get 'notices/:id/mark', to: 'notices#mark', as: :mark_notice
  get 'notices/:user/markall', to: 'notices#mark_all', as: :mark_notice_all
  delete 'notices/:user/delete', to: 'notices#destroy_has_read', as: :delete_notice_has_read
  
  resources :topics, shallow: true do
    resources :ideas do
      resources :likes, only: [:create, :destroy]
    end
  end
end
