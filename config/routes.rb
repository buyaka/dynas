Rails.application.routes.draw do
  
  mount Core::Engine => "/main", :as => 'core'
  #mount Service::Engine => "/services", :as => 'services'
  mount Console::Engine => "/console", :as => 'console'
  #mount Backend::Engine => "/admin", :as => 'admin'
  mount Frontend::Engine => "/", :as => 'frontend'
	mount Api::Engine => '/', :constraints => { :subdomain => 'api' }, :as => 'api'
  
  #mount Ad::Engine => "/services/ad", :as => 'ad'
  #mount Push::Engine => "/services/push", :as => 'push'
  #mount Passbook::Engine => "/services/pass", :as => 'pass'
  #mount IBeacon::Engine => "/services/ibeacon", :as => 'ibeacon'
  #mount BackgrounWorker::Engine => "/services/bworker", :as => 'bworker'

  namespace :services do
    mount Ad::Engine => "/ad", :as => 'ad'
    #mount Push::Engine => "/push", :as => 'push'
    #mount Passbook::Engine => "/pass", :as => 'pass'
    #mount IBeacon::Engine => "/ibeacon", :as => 'ibeacon'
    #mount BackgrounWorker::Engine => "/bworker", :as => 'bworker'
  end

end
