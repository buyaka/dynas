Core::Engine.routes.draw do
  devise_for :members, class_name: "Core::Member", module: :devise,  :controllers => { :omniauth_callbacks => "omniauth_callbacks" }
  resources :apps do
  	resources :entities do
      resources :fields
      resources :datas
      get "document", :on => :member
      
      # get "datas(.:format)", to: "datas#index"
#       get "datas/new(.:format)", to: "datas#new"
#       post "datas(.:format)", to: "datas#create"
#       get "datas/:id(.:format)", to: "datas#show"
#       get "datas/:id/edit(.:format)", to: "datas#edit"
#       put "datas/:id(.:format)", to: "datas#update"
#       patch "datas/:id(.:format)", to: "datas#update"
#       delete "datas/:id(.:format)", to: "datas#destroy"
    end
  end
  resources :field_types

end
