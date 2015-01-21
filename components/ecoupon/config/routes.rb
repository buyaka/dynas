Ecoupon::Engine.routes.draw do
	root to: "coupons#index"
	resources :coupons do
		get "banner", :on => :member
	end
end
