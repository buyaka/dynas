Ecoupon::Engine.routes.draw do
	root to: "coupons#index"
	resources :coupons do
		get "banner", :on => :member
	end

	get "coupons_with_beacon", to: "coupons#coupons_with_beacon"
	#get "coupons_with_beacon/:beacon_uuid", to: "coupons#coupons_with_beacon"
end
