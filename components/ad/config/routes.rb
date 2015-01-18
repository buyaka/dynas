Ad::Engine.routes.draw do
  resources :advertisers do
    resources :campaigns do 
      resources :advertises
    end
  end
  resources :ad_types
end
