Core::Engine.routes.draw do
  devise_for :members, class_name: "Core::Member", module: :devise,  :controllers => { :omniauth_callbacks => "omniauth_callbacks" }
  resources :apps do
  	resources :entities
  end
  resources :field_types

  get "crud_index", to: "crud#index" 
  post "crud_index", to: "crud#create" 
  get "crud_at", to: "crud#show"
  put "crud_at", to: "crud#update"  
  delete "crud_at", to: "crud#destroy"

end
