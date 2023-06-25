Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  namespace :api do
    namespace :v1 do
      resources :properties, only: [:create, :show, :index, :destroy, :update] do
        collection do
          get :search_by_owner
          get :search_by_filters
        end
        get :search_by_address, on: :collection
      end
      get '/api-docs/v1/swagger.yaml', to: 'swagger#index'
    end
  end
end
