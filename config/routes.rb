Rails.application.routes.draw do
  resources :proposals
  root 'home#welcome'

  get 'home/welcome'
  get 'welcome', to: 'home#welcome'

  get 'home/portal'
  get 'portal', to: 'home#portal'

  get 'home/about'
  get 'about', to: 'home#about'

  get 'home/help'
  get 'help', to: 'home#help'

  get 'home/patronage'
  get 'patronage', to: 'home#patronage'

  get 'home/donation-spending-policy'
  get 'donation-spending-policy', to: 'home#donation_spending_policy' 

  resources :verifications
  resources :comments
  resources :voices
  resources :choices
  resources :issues do
    get 'seen', on: :collection
  end
  resources :speakers
  resources :sessions, only: [:create, :new, :destroy]
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
