Core::Engine.routes.draw do
  devise_for :members, class_name: "Core::Member", module: :devise,  :controllers => { :omniauth_callbacks => "omniauth_callbacks" }
  resources :apps do
  	resources :boxes
  end
  resources :field_types
end
