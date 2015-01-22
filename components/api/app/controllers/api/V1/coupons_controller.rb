module Api
  module V1
    class CouponsController < ApplicationController
      before_filter :get_required_data
      respond_to :json

      def index
        beacon = Ibeacon::Beacon.where(:uuid => params[:beacon_uuid]).first
        @coupons = Ecoupon::Coupon.where(:beacon_id => beacon.id)zsa
        puts @coupons.to_json
        respond_with(@coupons, :status => 200)
      end

      private

        def get_required_data
          
          @member_id = request.headers['MEMBERID'].to_s

          if @member_id == nil
            respond_with :status => 400
            return
          end

          @member = Core::Member.find(@member_id)
          if @member == nil 
            respond_with :status => 401
            return
          end

          Thread.current[:member] = @member_id

        end

    end
  end
end