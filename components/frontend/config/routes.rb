Frontend::Engine.routes.draw do
  get 'main/index'
  get 'main/services'
  get 'main/pricing'
  get 'main/contact'
  get 'main/about'

  root :to => 'main#index'
end
