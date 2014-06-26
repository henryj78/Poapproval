Poapproval::Application.routes.draw do
  
  resources :orders do 
    collection do 
      post :import 
      get "approved"
      get "received"
    end
  end
  

  get "/log-in" => "sessions#new"
  post "/log-in" => "sessions#create", as: :log_in
  get "/log-out" => "sessions#destroy", as: :log_out
  get "sign_up" => "users#new", :as => "sign_up"
  
  resources :users
  root 'sessions#new'
end
