Api::Engine.routes.draw do
  
  namespace :v1 do
    get "crud_index", to: "crud#index" 
    post "crud_index", to: "crud#create"
    get "crud_at", to: "crud#show"
    put "crud_at", to: "crud#update"  
    delete "crud_at", to: "crud#destroy"
    
	  post 'signup', to: 'auth#signup'
	  post 'signin', to: 'auth#signin'
	  post 'reset_password', to: 'auth#reset_password'
	  get 'get_token', to: 'auth#get_token'  
	  get 'clear_token', to: 'auth#clear_token'	
    
    get 'coupons_with_beacon', to: 'coupons#index'
    get 'coupons', to: 'coupons#list'
    get "coupon_image/:coupon_id", to: 'coupons#banner'
  end
	
end
