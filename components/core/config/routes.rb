Core::Engine.routes.draw do
  devise_for :members, class_name: "Core::Member", module: :devise,  :controllers => { :omniauth_callbacks => "omniauth_callbacks" }
  resources :apps do
  	resources :entities
  end
  resources :field_types

  #namespace :api do
  #  namespace :v1 do
      #Core::CrudController.action_methods.each do |action|
      #  get "/crud_#{action}", to: "crud##{action}", as: "crud_#{action}"
      #end
  #  end
  #end

  get "crud_index", to: "crud#index" 
  post "crud_index", to: "crud#create" 
  get "crud_at", to: "crud#show"
  put "crud_at", to: "crud#update"  
  delete "crud_at", to: "crud#destroy"
  
  #Core::Box.all.each do |b|
  #  puts "Routing #{b.name}"
  #  get "/#{b.name}", :to => "crud#show", defaults: { id: b.id }
  #end

  #Core::CrudController.action_methods.each do |action|
  #  get "/#{action}", to: "pages##{action}", as: "#{action}_page"
  #end

end
