Rails.application.routes.draw do
  mount Ckeditor::Engine => '/ckeditor'
  root to: "intranet#dashboard"
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords'
  }
  
  resources :posts
  get '/intranet/members'
  get '/intranet/members/:id' => "intranet#personal", as: :member
  get '/intranet/dashboard'
  get '/intranet/notice'
  get '/intranet/freeboard'
  get '/intranet/gallery'
  get '/intranet/events', as: :event
  get '/intranet/homework', as: :homework
  get '/intranet/search', as: :search
  get '/intranet/notice/write' => 'intranet#editor', as: :nedit
  get '/intranet/freeboard/write' => 'intranet#editor', as: :fedit
  post '/intranet/post/save' => 'intranet#savePost', as: :create_post
  get '/intranet/post/view/:id' => 'intranet#viewPost', as: :view
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
