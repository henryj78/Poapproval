Poapproval::Application.routes.draw do
  
  resources :buyers

  namespace :api, defaults: {format: 'json'} do
   namespace :v1 do
     resources :orders do 
       collection do 
         post :import 
         get "approved"
         get "received"
         get "declined"
         get "load_data"
         get "details"
         get "buyers"
         get "auth"
         get "submit_approval"
         get "submit_decline"
       end#end collection
     end #end resources
    end #end v1
  end #end api   
      
  resources :orders do 
    collection do 
      post :import 
      get "approved"
      get "received"
      get "decline"
      get "decline_rpt"
      get "load_data"
      get "details"
    end
  end
  

  get "/log-in" => "sessions#new"
  post "/log-in" => "sessions#create", as: :log_in
  get "/log-out" => "sessions#destroy", as: :log_out
  get "sign_up" => "users#new", :as => "sign_up"
  
  resources :users
  root 'sessions#new'
end
