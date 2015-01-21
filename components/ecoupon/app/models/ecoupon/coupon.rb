module Ecoupon
	class Coupon
		include NoBrainer::Document
		include NoBrainer::Document::Timestamps
	  	store_in :database => ->{ "#{Thread.current[:member]}" }

		field :name, :type => String
		field :banner, :type => Binary
		field :banner_file_name, :type => String
		field :banner_content_type, :type => String
		field :beacon_id, :type => String
		field :url, :type => String

	end
end
