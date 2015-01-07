Rails.application.routes.draw do
  
  mount Core::Engine => "/main", :as => 'core'
  mount Service::Engine => "/main/services"
  mount Console::Engine => "/console"
  #mount Backend::Engine => "/admin"
  mount Frontend::Engine => "/"
  #mount Api::Engine => "/api"
  
end
