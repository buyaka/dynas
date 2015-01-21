Rails.application.routes.draw do
  
  mount Core::Engine => "/main", :as => 'core'
  #mount Console::Engine => "/console", :as => 'console'
  #mount Backend::Engine => "/admin", :as => 'admin'
  mount Api::Engine => '/', :constraints => { :subdomain => 'api' }, :as => 'api'
  mount Frontend::Engine => "/", :as => 'frontend'

  namespace :services do
    mount Ad::Engine => "/ad", :as => 'ad'
    mount Ibeacon::Engine => "/ibeacon", :as => 'ibeacon'
    mount Ecoupon::Engine => "/ecoupon", :as => 'ecoupon'
    #mount Push::Engine => "/push", :as => 'push'
    #mount Passbook::Engine => "/pass", :as => 'pass'
    #mount BackgrounWorker::Engine => "/bworker", :as => 'bworker'
  end 

end
