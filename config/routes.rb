Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root 'sessions#new'
  get 'singlechoices/new'

  get 'genres/new'

  get 'subgenres/new'

  get 'subgenre/new'

  get 'quizzes/new'

  get 'sessions/new'

  get 'genres/new'

  get 'users/new'
  get 'redirection', to: 'sessions#redirection'
  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  get   '/allgenres', to: 'genres#all'
  get '/allsubgenres', to: 'subgenres#all'
  get '/allquestions', to: 'singlechoices#all'
  post '/currentquestion', to: 'quizzes#currentquestion'
  post '/newquiz',   to: 'quizzes#create'
  get '/fifty',  to:    'quizzes#fifty50'
  post '/quizdone',   to: 'quizzes#quizdone'
  post '/skipquestion', to: 'quizzes#skipquestion'
  resources :users
  resources :quizzes


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
