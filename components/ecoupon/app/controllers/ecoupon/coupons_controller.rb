module Ecoupon
  class CouponsController < ApplicationController
    before_filter :get_required_data
    before_action :set_coupon, only: [:show, :edit, :update, :destroy, :banner]

    respond_to :html

    def index
      @coupons = Coupon.all
      respond_with(@coupons)
    end

    def show
      if @coupon.beacon_id != nil
        @beacon = Ibeacon::Beacon.find(@coupon.beacon_id)
      end
      respond_with(@coupon)
    end

    def new
      @coupon = Coupon.new
      respond_with(@coupon)
    end

    def edit
    end

    def create

      banner = coupon_params[:banner]
      content = coupon_params
      if banner != nil
        content[:banner] = banner.read
        content[:banner_file_name] = banner.original_filename
        content[:banner_content_type] = banner.content_type
      end
      @coupon = Coupon.new(content)
      @coupon.save
      respond_with(@coupon)
    end

    def update
      @coupon.update(coupon_params)
      respond_with(@coupon)
    end

    def destroy
      @coupon.destroy
      respond_with(@coupon)
    end

    def banner
      send_data(@coupon.banner, :type => @coupon.banner_content_type, :filename => "#{@coupon.banner_file_name}.jpg", :disposition => "inline")
    end

    private
    def set_coupon
      @coupon = Coupon.find(params[:id])
    end

    def coupon_params
      params.require(:coupon).permit(:name, :banner, :beacon_id)
    end

    def get_required_data
      Thread.current[:member] = current_member.id
    end
  end
end