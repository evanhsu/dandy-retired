Dandy::Application.routes.draw do
  resources :helibases

  resources :hotels
  resources :dispatch_centers

  resources :frequencies do
    collection do
      post 'sort'
    end
  end
  
  match 'radio_groups/menu' => 'radio_groups#menu', :via => :get, :as => :menu_for_radio_groups
  resources :radio_groups, :except => [:index, :show, :create]
  resources :radio_groups, :only => [:update] do
    member do
      put 'update_frequencies' => 'radio_groups#update_frequencies'
    end
  end
  resources :radio_groups, :only => [:index, :show, :create] do
    member do
      get 'frequencies' => 'radio_groups#frequencies', :as => :frequencies_for
      get 'test' => 'radio_groups#test', :as => :test_for
    end
  end
  
  resources :training_priorities do
    collection do
      post 'sort'
    end
  end

  resources :crewmembers
  resources :crews, :except => [:index, :create]
  resources :crews, :only => [:index, :create] do
    member do
      get 'crewmembers' => 'crews#crewmembers', :as => :crewmembers_for
      get 'new_crewmember' => 'crewmembers#new_crewmember_for_crew', :as => :new_crewmember_for
      get 'hotels' => 'crews#hotels', :as => :hotels_for
      get 'info' => 'crews#info', :as => :info_for
      get 'helibase' => 'crews#helibase', :as => :helibase_for
      get 'staffing' => 'crews#staffing', :as => :staffing_for
    end
  end

  resources :users
  resources :staffing_levels

  resources :rotation_board
  
  #session routes
  match 'login' => 'sessions#create', :as => :login, :via => :post
  match 'login' => 'welcome#index', :as => :login, :via => :get
  match 'logout' => 'sessions#destroy', :as => :logout

  match '/' => 'staffing_levels#index', :constraints => { :subdomain => /staffing/i }
  #match '/' => 'crews#show', :constraints => { :subdomain => /dandy/i }
  #match '' => 'welcome#index', :constraints => { :subdomain => /.+/ }


  root :to => 'welcome#index'
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
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
