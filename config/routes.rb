Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      scope :merchants, module: :merchants do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random', to: 'random#show'
        get '/most_revenue', to: 'most_revenue#index'
        get '/:merchant_id/favorite_customer', to: 'favorite_customer#show'
      end

      resources :merchants, only: [:index, :show] do
        scope module: :merchants do
          resources :items, only: :index
          resources :invoices, only: :index
        end
      end

      scope :customers, module: :customers do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get 'random', to: 'random#show'
      end
      resources :customers, only: [:index, :show] do
        scope module: :customers do
          resources :invoices, only: :index
          resources :transactions, only: :index
        end
      end

      scope :items do
        get '/find', to: 'items#find'
        get '/find_all', to: 'items#find_all'
        get '/random', to: 'items#random'
      end
      resources :items, only: [:index, :show] do
        scope module: :items do
          resources :invoice_items, only: :index
          resources :merchant, only: :index
        end
      end

      scope :invoices, module: :invoices do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random', to: 'random#show'
      end
      resources :invoices, only: [:index, :show] do
        scope module: :invoices do
          resources :transactions, only: :index
          resources :invoice_items, only: :index
          resources :items, only: :index
          resources :customer, only: :index
          resources :merchant, only: :index
        end
      end

      scope :transactions do
        get '/find', to: 'transactions#find'
        get '/find_all', to: 'transactions#find_all'
        get '/random', to: 'transactions#random'
      end
      resources :transactions, only: [:index, :show] do
        scope module: :transactions do
          resources :invoice, only: :index
        end
      end

      scope :invoice_items, module: :invoice_items do
        get '/find', to: 'search#show'
        get '/find_all', to: 'search#index'
        get '/random', to: 'random#show'
      end
      resources :invoice_items, only: [:index, :show] do
        scope module: :invoice_items do
          resources :invoice, only: :index
          resources :item, only: :index
        end
      end
    end
  end
end
