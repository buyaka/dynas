Api::Engine.routes.draw do
  get "crud_index", to: "crud#index" 
  post "crud_index", to: "crud#create"
  get "crud_at", to: "crud#show"
  put "crud_at", to: "crud#update"  
  delete "crud_at", to: "crud#destroy"

  root to: "crud#index" 
end
