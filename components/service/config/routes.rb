Service::Engine.routes.draw do
  get 'main/index'
  root :to => 'main#index'
end
