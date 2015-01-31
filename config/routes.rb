Rails.application.routes.draw do
  resources :reports

  get 'welcome/banner'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  
  resources :councils do
    member do
      get 'adjust_weights'
    end
    member do
      post 'save_weights'
    end
    member do
      get 'select_asset_types'
    end
    member do
      post 'save_asset_types'
    end
    resources :council_priority_weights, only: [:index]
    resources :council_asset_types, only: [:new, :create, :index, :destroy]
  end
  resources :assets do
    resources :asset_components, only: [:show, :index, :edit, :update]
  end    
  resources :users
  resources :components
  resources :council_reports do
    resources :report_assets, only: [:new, :create, :index, :destroy] do
      collection do
        post 'generate'
      end
    end
    resources :reports, only: [:index] do
      member do
        get 'proposed_works_summary'
      end
    end
    resources :asset_assessments, only: [:show, :index, :edit, :update]
    resources :proposed_works do
      member do
        get 'piece_of_work'
      end
    end
    member do
      get 'select_assets'
    end
    member do
      post 'save_assets'
    end
  end 
  resources :sessions, only: [:new, :create, :destroy]
  
  #connect ':controller/:action/:id', :id => /\w+(,\w+)*/
  
  match '/signin', to: 'sessions#new', via: 'get'
  match '/signout', to: 'sessions#destroy', via: 'delete'
  match '/contact', to: 'welcome#contact', via: 'get'
  match '/about', to: 'welcome#about', via: 'get'
  match '/help', to: 'welcome#help', via: 'get'
  

  # You can have the root of your site routed with "root"
  root 'welcome#banner'

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
