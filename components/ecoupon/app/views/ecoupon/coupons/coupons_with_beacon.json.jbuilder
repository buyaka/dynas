json.array!(@coupons) do |coupon|
  json.extract! coupon, :id, :name, :banner, :beacon_id
  json.url coupon_url(coupon, format: :json)
end
